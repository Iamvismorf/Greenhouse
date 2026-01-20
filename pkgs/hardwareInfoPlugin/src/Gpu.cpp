#include "../include/Gpu.hpp"

class AmdsmiManager final {
public:
  AmdsmiManager(const AmdsmiManager &) = delete;
  AmdsmiManager &operator=(const AmdsmiManager &) = delete;
  static AmdsmiManager &get() {
    static AmdsmiManager internal;
    return internal;
  }
  void init() {
    if (mCreated) {
      return;
    }
    amdsmi_init(AMDSMI_INIT_AMD_GPUS);
    mCreated = true; // idealy check if init is succsessfull
  }
  ~AmdsmiManager() { amdsmi_shut_down(); }

private:
  AmdsmiManager() {};
  bool mCreated = false;
};

QString SocketInfo::getSocketName() const { return socketName; }
SocketInfo::SocketInfo(QObject *parent) : QObject(parent) {}
GpuInfo::GpuInfo(QObject *parent, amdsmi_processor_handle gpuId)
    : QObject(parent), gpuId(gpuId) {}
QString GpuInfo::getMarketName() const { return marketName; }
qint64 GpuInfo::getEdgeTemperature() const { return edgeTemperature; }
qint64 GpuInfo::getHotspotTemperature() const { return hotspotTemperature; }
quint64 GpuInfo::getTotalVram() const { return totalVram; }
quint64 GpuInfo::getUsedVram() const { return usedVram; }
quint32 GpuInfo::getGfx() const { return gfx; }

Gpu::Gpu(QObject *parent) : QObject(parent), mpTimer(new QTimer(this)) {
  // amdsmi_status_t initStat = amdsmi_init(AMDSMI_INIT_AMD_GPUS);
  AmdsmiManager::get().init();

  uint32_t socketCount = 0;
  amdsmi_get_socket_handles(&socketCount, nullptr);
  QList<amdsmi_socket_handle> socketstmp(socketCount);
  mSockets.reserve(socketCount);

  amdsmi_get_socket_handles(&socketCount, socketstmp.data());

  for (const auto &socket : socketstmp) {
    SocketInfo *pSocketinfo = new SocketInfo(this);
    uint32_t gpuCount = 0;
    pSocketinfo->socketId = socket;

    amdsmi_get_socket_info(socket, 128, pSocketinfo->socketName);

    amdsmi_get_processor_handles(socket, &gpuCount, nullptr);
    pSocketinfo->gpus.reserve(gpuCount);
    QList<amdsmi_processor_handle> gpus(gpuCount);
    amdsmi_get_processor_handles(socket, &gpuCount, gpus.data());
    for (const auto &gpu : gpus) {
      GpuInfo *gpuinfo = new GpuInfo(pSocketinfo, gpu);
      pSocketinfo->gpus.push_back(gpuinfo);
    }
    mSockets.push_back(pSocketinfo);
  }
  connect(mpTimer, &QTimer::timeout, this, &Gpu::updateGpusInfo);
  updateGpusInfo();
  mpTimer->start(1000);
}

void Gpu::updateGpusInfo() {
  for (SocketInfo *pSocket : mSockets) {
    for (GpuInfo *gpu : pSocket->gpus) {
      amdsmi_engine_usage_t gpuUsage;

      if (gpu->marketName.isEmpty()) {
        amdsmi_asic_info_t boardInfo;
        amdsmi_get_gpu_asic_info(gpu->gpuId, &boardInfo);
        gpu->marketName = boardInfo.market_name;
      }

      amdsmi_get_temp_metric(
          gpu->gpuId, amdsmi_temperature_type_t::AMDSMI_TEMPERATURE_TYPE_EDGE,
          amdsmi_temperature_metric_t::AMDSMI_TEMP_CURRENT,
          &gpu->edgeTemperature);
      emit gpu->edgeTemperatureChanged();
      amdsmi_get_temp_metric(
          gpu->gpuId,
          amdsmi_temperature_type_t::AMDSMI_TEMPERATURE_TYPE_HOTSPOT,
          amdsmi_temperature_metric_t::AMDSMI_TEMP_CURRENT,
          &gpu->hotspotTemperature);
      emit gpu->hotspotTemperatureChanged();

      if (gpu->totalVram == 0) {
        amdsmi_get_gpu_memory_total(gpu->gpuId,
                                    amdsmi_memory_type_t::AMDSMI_MEM_TYPE_VRAM,
                                    &gpu->totalVram);
      }
      amdsmi_get_gpu_memory_usage(gpu->gpuId,
                                  amdsmi_memory_type_t::AMDSMI_MEM_TYPE_VRAM,
                                  &gpu->usedVram);
      emit gpu->usedVramChanged();
      amdsmi_get_gpu_activity(gpu->gpuId, &gpuUsage);
      gpu->gfx = gpuUsage.gfx_activity;
      emit gpu->gfxChanged();

      gpu->umc = gpuUsage.umc_activity;
      gpu->mm = gpuUsage.mm_activity;
    }
  }
  // for (SocketInfo *sock : mSockets) {
  //   qDebug() << *sock << Qt::endl;
  // }
}

QQmlListProperty<SocketInfo> Gpu::sockets() {
  return QQmlListProperty<SocketInfo>(this, &mSockets);
}
QQmlListProperty<GpuInfo> SocketInfo::getGpus() {
  return QQmlListProperty<GpuInfo>(this, &gpus);
}

Gpu::~Gpu() {
  // amdsmi_status_t shutdown = amdsmi_shut_down();
  // qDebug() << "shutdown status: ";
  mpTimer->stop();
}
