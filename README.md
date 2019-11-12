# jenkins-server

#### Deploy using
```
. deploy.sh
```

#### Destroy using
```
. destroy.sh
```

#### Use it by opening
```
http://localhost:8080/blue
```

#### Port forwarding (in case of using a remote server). Run cmd and:
```
ssh -L 8080:localhost:8080 <USER>@<SERVER>
```


## Getting a plugin list

### Manually create a container:
`docker run -p 8080:8080 jenkinsci/blueocean`
### Get the admin password shown when installing
```
*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

8b1f8ed73f3f4147b65d1c65a4ae5401

This may also be found at: /var/jenkins_home/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************
```
### Proceed with the installation, set the new admin credentials as 'admin:admin' and install the suggested plugins
### Make sure 'jq' is installed and get the plugin list:
`curl -s -k "http://admin:admin@localhost:8080/pluginManager/api/json?depth=1" | jq -r '.plugins[].shortName' | tee plugins.txt`
### Source
https://technologyconversations.com/2017/06/16/automating-jenkins-docker-setup/
