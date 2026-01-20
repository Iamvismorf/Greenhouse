#pragma once
#include <QFile>
#include <QObject>
#include <QTimer>
#include <qqmlintegration.h>
#include <qtmetamacros.h>
class Cpu : public QObject {
  Q_OBJECT
  QML_SINGLETON
  QML_ELEMENT
  Q_PROPERTY(qreal utilized READ utilized NOTIFY utilizedChanged)

public:
  explicit Cpu(QObject *parent = nullptr);
  ~Cpu();

  qreal utilized() const;
signals:
  void utilizedChanged();

private:
  qreal mUtilized = 0;
  qulonglong mLastTotalTime = 0;
  qulonglong mLastIdleTime = 0;
  QFile mFile;
  QTimer *mpTimer = nullptr;
  void updateUtilized();
};
