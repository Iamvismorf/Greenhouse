#include <../include/Ram.hpp>
Ram::Ram(QObject *parent)
    : QObject(parent), mFile("/proc/meminfo"), mpTimer(new QTimer(this)) {
  if (!mFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
    return;
  }
  mTotal = extractNumberFromLine(mFile.readLine());
  connect(this, &Ram::usedChanged, this, &Ram::updateUtilized);
  connect(mpTimer, &QTimer::timeout, this, &Ram::updateUsed);
  updateUsed();
  mpTimer->start(1000);
}
Ram::~Ram() { mFile.close(); }
qulonglong Ram::extractNumberFromLine(const QByteArray &rLine) {
  QRegularExpression re("\\d+(?= kb)",
                        QRegularExpression::CaseInsensitiveOption);
  return re.match(rLine).captured(0).toULongLong();
}
void Ram::updateUtilized() {
  mUtilized = static_cast<qreal>(mUsed) / mTotal;
  emit utilizedChanged();
}
void Ram::updateUsed() {
  mFile.seek(0);
  for (size_t i = 0; i < 2; ++i) {
    mFile.readLine();
  }
  qulonglong memAvailable = extractNumberFromLine(mFile.readLine());
  mUsed = mTotal - memAvailable;
  emit usedChanged();
}
qulonglong Ram::total() const { return mTotal; }
qulonglong Ram::used() const { return mUsed; }
qreal Ram::utilized() const { return mUtilized; }
