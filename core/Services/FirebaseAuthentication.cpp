#include "FirebaseAuthentication.h"

FirebaseAuthentication::FirebaseAuthentication(DataBaseStorage &dbStorage ,QObject *parent)
    : AuthenticationProvider(dbStorage ,parent),
    _dbStorage(dbStorage)
{
//    connect(QtFirebaseAuth::instance(), &QtFirebaseAuth::userExists, this, &FirebaseAuthentication::userExists);
//    connect(QtFirebaseAuth::instance(), &QtFirebaseAuth::userCreated, this, &FirebaseAuthentication::userSaved);
//    connect(QtFirebaseAuth::instance(), &QtFirebaseAuth::userNotFound, this, &FirebaseAuthentication::userNotFound);
//    connect(QtFirebaseAuth::instance(), &QtFirebaseAuth::wrongPasswordDetected, this, &FirebaseAuthentication::wrongPasswordDetected);
//    connect(QtFirebaseAuth::instance(), &QtFirebaseAuth::userSignedIn, this, &FirebaseAuthentication::signedIn);
}

QString FirebaseAuthentication::userId() const {
//    QtFirebaseAuth::instance()->uid();
}

void FirebaseAuthentication::saveUser(const QString &email, const QString &password) {
//    QtFirebaseAuth::instance()->registerUser(email, password);
}

void FirebaseAuthentication::checkIfUserExists(const QString &email) {
//    QtFirebaseAuth::instance()->fetchProvidersForEmail(email);
}

void FirebaseAuthentication::signIn(const QString &email, const QString &password) {
//    QtFirebaseAuth::instance()->signIn(email, password);
}

void FirebaseAuthentication::signOut() {
//    QtFirebaseAuth::instance()->signOut();
}

bool FirebaseAuthentication::isSignedIn() {
//    QtFirebaseAuth::instance()->signedIn();
}
