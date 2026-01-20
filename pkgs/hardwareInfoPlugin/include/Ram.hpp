#pragma once
#include <QObject>
#include <QtQmlIntegration>
#include <qqmlintegration.h>
#include <qtmetamacros.h>
class Ram : public QObject {
  Q_OBJECT
  QML_ELEMENT
  QML_SINGLETON
  Q_PROPERTY(qulonglong total READ total NOTIFY totalChanged)
  Q_PROPERTY(qulonglong used READ used NOTIFY usedChanged)
  Q_PROPERTY(qreal utilized READ utilized NOTIFY utilizedChanged)

public:
  explicit Ram(QObject *parent = nullptr);
  ~Ram();
  qulonglong total() const;
  qulonglong used() const;
  qreal utilized() const;
signals:
  void totalChanged();
  void usedChanged();
  void utilizedChanged();

private:
  qulonglong mTotal = 0;
  qulonglong mUsed = 0;
  qreal mUtilized = 0;
  QFile mFile;
  QTimer *mpTimer = nullptr;
  void updateUsed();
  void updateUtilized();
  qulonglong extractNumberFromLine(const QByteArray &rLine);
};
