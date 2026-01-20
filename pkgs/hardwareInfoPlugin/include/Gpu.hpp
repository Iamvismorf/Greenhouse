// todo: emit signals in cpp
#include <QObject>
#include <QQmlListProperty>
#include <QtQmlIntegration>
#include <amd_smi/amdsmi.h>
#include <qtmetamacros.h>

class GpuInfo final : public QObject {
  Q_OBJECT
  Q_PROPERTY(QString marketName READ getMarketName CONSTANT)
  Q_PROPERTY(qint64 edgeTemperature READ getEdgeTemperature NOTIFY
                 edgeTemperatureChanged)
  Q_PROPERTY(qint64 hotspotTemperature READ getHotspotTemperature NOTIFY
                 hotspotTemperatureChanged)
  Q_PROPERTY(quint64 totalVram READ getTotalVram CONSTANT)
  Q_PROPERTY(quint64 usedVram READ getUsedVram NOTIFY usedVramChanged)
  Q_PROPERTY(quint32 gfx READ getGfx NOTIFY gfxChanged)

public:
  QString getMarketName() const;
  qint64 getEdgeTemperature() const;
  qint64 getHotspotTemperature() const;

  quint64 getTotalVram() const;
  quint64 getUsedVram() const;
  quint32 getGfx() const;
  GpuInfo(QObject *parent, amdsmi_processor_handle gpuId);

  amdsmi_processor_handle gpuId;
  QString marketName;

  int64_t edgeTemperature = 0;
  int64_t hotspotTemperature = 0;

  uint64_t totalVram = 0;
  uint64_t usedVram = 0;

  // todo
  uint32_t gfx = 0;
  uint32_t umc = 0;
  uint32_t mm = 0;
signals:
  void edgeTemperatureChanged();
  void hotspotTemperatureChanged();
  void usedVramChanged();
  void gfxChanged();
};
class SocketInfo final : public QObject {
  Q_OBJECT
  Q_PROPERTY(QString socketName READ getSocketName CONSTANT)
  Q_PROPERTY(QQmlListProperty<GpuInfo> gpus READ getGpus CONSTANT)
public:
  QQmlListProperty<GpuInfo> getGpus();
  QString getSocketName() const;
  SocketInfo(QObject *parent);
  amdsmi_socket_handle socketId;
  char socketName[128];
  QList<GpuInfo *> gpus;
};
class Gpu : public QObject {
  Q_OBJECT
  QML_ELEMENT
  QML_SINGLETON
  Q_PROPERTY(QQmlListProperty<SocketInfo> sockets READ sockets CONSTANT);

public:
  explicit Gpu(QObject *parent = nullptr);
  QQmlListProperty<SocketInfo> sockets();
  Q_INVOKABLE void initFunc() { return; }
  ~Gpu();

private:
  QList<SocketInfo *> mSockets;
  QTimer *mpTimer = nullptr;
  void updateGpusInfo();
};
