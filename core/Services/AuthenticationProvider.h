#ifndef AUTHENTICATIONPROVIDER_H
#define AUTHENTICATIONPROVIDER_H

#include <QObject>
#include <Storage/DataBaseStorage.hpp>

class AuthenticationProvider : public QObject
{
    Q_OBJECT
public:
    explicit AuthenticationProvider(DataBaseStorage &db ,QObject *parent = nullptr);
    
    virtual QString userId() const = 0;
    virtual void saveUser(const QString& email, const QString& password) = 0;
    virtual void checkIfUserExists(const QString& email) = 0;
    
    virtual void signIn(const QString& email, const QString& password) = 0;
    virtual void signOut() = 0;
    virtual bool isSignedIn() = 0;

signals:
    void userExists(bool exists);
    void userSaved();
    void signedIn();
    void wrongPasswordDetected();
    void userNotFound();
    

};

#endif // AUTHENTICATIONPROVIDER_H
