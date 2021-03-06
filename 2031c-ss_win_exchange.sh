

###
# Create Service Set: "Windows_Agent_Exchange"
###
# Service Template for Service Set
RES=`icingacli director serviceset exists "Windows_Agent_Exchange"`
if [[ $RES =~ "does not exist" ]]
then
icingacli director serviceset create --json '
{
    "object_name": "Windows_Agent_Exchange",
    "object_type": "template"
}
'


####
# Services: Performance Data
####
icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Agent_Win_Counter"
    ],
    "object_name": "MSExch2016_IS_ActiveMailboxes",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
        "nscp_counter_critical": "1000",
        "nscp_counter_name": "\\MSExchangeIS Store(_total)\\Active mailboxes",
        "nscp_counter_warning": "500",
        "nscp_modules": "CheckSystem",
		"nscp_query": "check_pdh"
    }
}
'

icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Agent_Win_Counter"
    ],
    "object_name": "MSExch2016_AD_Replication",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange",
    "vars": {
        "nscp_counter_critical": "1000",
        "nscp_counter_name": "\\MSExchange Mailbox Replication Service\\Resource Health: AD Replication",
        "nscp_counter_warning": "500",
        "nscp_modules": "CheckSystem",
	"nscp_query": "check_pdh"
    }
}
'

# Windows Services
icingacli director service create --json '
{
    "disabled": false,
    "imports": [
        "Exchange Services"
    ],
    "object_name": "Exchange Services",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

#Powershell Checks
icingacli director service create --json '
{
    "imports": [
        "Exchange2016 FullBackup status"
    ],
    "object_name": "Exchange2016 FullBackup status",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

icingacli director service create --json '
{
    "imports": [
        "Exchange2016 IncrementalBackup status"
    ],
    "object_name": "Exchange2016 IncrementalBackup status",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

icingacli director service create --json '
{
    "imports": [
        "Exchange2016 Mailbox Health status"
    ],
    "object_name": "Exchange2016 Mailbox Health status",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

icingacli director service create --json '
{
    "imports": [
        "Exchange2016 QueueHealth status"
    ],
    "object_name": "Exchange2016 QueueHealth status",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

######################
#HTTPS Checks
#Certificate
icingacli director service create --json '
{
    "imports": [
        "http_certificate_validity"
    ],
    "object_name": "HTTPS Certificate Validity",
    "object_type": "object",
	"service_set": "Windows_Agent_Exchange"
}
'

# HTTP 
icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX ActiveSync",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/Microsoft-Server-ActiveSync\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'
icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX Autodiscover",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/Autodiscover\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'

icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX MAPI",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/MAPI\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'

icingacli director service create --json '
{
    "imports": [
        "https_exchange_owa"
    ],
    "object_name": "HTTP MSEX OWA",
    "object_type": "object",
    "service_set": "Windows_Agent_Exchange",
    "vars": {
       "http_uri": "\/OWA\/HealthCheck.htm",
       "http_string": "OK"
    }
}
'



echo "[+] Service Set 'Windows_Agent_Exchange' created."
fi



