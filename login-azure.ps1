#login to azure 


function Login-Azure
{
   $username = "cobey.errett@cloud.statcan.ca"
   $password = get-content C:\statcan\azureps\azure.txt | convertto-securestring
   
   $credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist $username,$password

   $AzureRMAccount = Add-AzureRmAccount -Credential $credentials
   return $AzureRMAccount
}

function login-proxy
{
    $username = "errecob"
    $password = get-content C:\statcan\azureps\proxy.txt | convertto-securestring
    $webclient=New-Object System.Net.WebClient
    $credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist $username,$password
    $webclient.Proxy.Credentials=$credentials

}
