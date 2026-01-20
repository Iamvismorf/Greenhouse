#include "../include/Cpu.hpp"
#include <QDebug>

Cpu::Cpu(QObject *parent)
    : QObject(parent), mFile("/proc/stat"), mpTimer(new QTimer(this)) {
  if (!mFile.open(QIODevice::ReadOnly)) {
    qDebug() << "something went wrong!";
    return;
  }
  connect(mpTimer, &QTimer::timeout, this, &Cpu::updateUtilized);
  updateUtilized();
  mpTimer->start(1000);
}
Cpu::~Cpu() { mFile.close(); }
qreal Cpu::utilized() const { return mUtilized; }
void Cpu::updateUtilized() {
  mFile.seek(0);
  qulonglong totalTime = 0;
  qulonglong idleTime = 0;

  QList<QByteArray> fLine = mFile.readLine().mid(3).simplified().split(' ');
  for (const auto &time : fLine) {
    totalTime += time.toULongLong();
  }
  idleTime = fLine.at(3).toULongLong() + fLine.at(4).toULongLong();

  qulonglong deltaTotalTime = totalTime - mLastTotalTime;
  qulonglong deltaIdleTime = idleTime - mLastIdleTime;

  mUtilized =
      static_cast<qreal>(deltaTotalTime - deltaIdleTime) / deltaTotalTime;
  mLastTotalTime = totalTime;
  mLastIdleTime = idleTime;
  emit utilizedChanged();
}
