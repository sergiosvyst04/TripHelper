#ifndef FIREBASEAUTHENTICATION_H
#define FIREBASEAUTHENTICATION_H

#include <QObject>
#include <Storage/DataBaseStorage.hpp>
#include <Services/AuthenticationProvider.h>
#include <src/qtfirebaseauth.h>

class FirebaseAuthentication : public AuthenticationProvider
{
    Q_OBJECT
public:
    explicit FirebaseAuthentication(DataBaseStorage& dbStorage ,QObject *parent = nullptr);
    
    QString userId() const override;
    void saveUser(const QString& email, const QString& password) override;
    void checkIfUserExists(const QString& email) override;
    
    void signIn(const QString& email, const QString& password) override;
    void signOut() override;
    bool isSignedIn() override;
signals:
    
private:
    DataBaseStorage &_dbStorage;    
};

#endif // FIREBASEAUTHENTICATION_H
