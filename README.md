# web-handlers
WebHandlers

# Server Setup #

This workshops requires a PASOE instance, connected to the Sport2000 database.


## Sports2000 database ##
A Sports2000 database is required for the PASOE instance; either an existing version can be used, or a new one must be created and served.

To create a new Sports2000 database, open ProEnv.
```
proenv>mkdir c:\temp\sports2000
proenv>cd c:\temp\sports2000
proenv>prodb sports2000 sports2000
proenv>proserve sports2000
```

## PASOE Configuration ##
A vanilla/default configuration will be used, with minor modification.

### Create the PASOE instance ###
Open ProEnv
```
proenv> pasman create -f c:\temp\web-handlers-workshop
```
This uses the default ports: HTTP=8810, HHTPS=8811 and deploys the ROOT, oemanager and manager webapps into the instance.
If you have an instance already running on those ports, they can be changed by adding `-p <http-port> -P <https-port>` to the `pasman`` command


### Update openedge.properties ###
A Sports2000 database must be connected.

Modify the properties in `C:\temp\web-handlers-workshop\conf\openedge.properties`.

PROPATH must have the Git repo root added to it. Other properties in the section should remain unchanged.

```
[AppServer.Agent.web-handlers-workshop]
    PROPATH=<repo-root>,${CATALINA_BASE}/webapps/ROOT/WEB-INF/openedge,${CATALINA_BASE}/ablapps/web-handlers-workshop/openedge,${CATALINA_BASE}/openedge,${DLC}/tty,${DLC}/tty/netlib/OpenEdge.Net.pl

```
The startup parameters must have the Sports2000 database added to it. Other properties in the section should remain unchanged.
The path to the Sports2000 database may differ if you did not create a new one.
```
[AppServer.SessMgr.web-handlers-workshop]
    agentStartupParam=-T "${CATALINA_BASE}/temp" -db c:/temp/sports2000
```

## (Re)Start the instance ##
Open ProEnv
```
proenv> pasman pasoestart -restart -I web-handlers-workshop
```

## Stop an instance ##
Open ProEnv
```
proenv> pasman stop -I web-handlers-workshop
```
