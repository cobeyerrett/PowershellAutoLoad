#login to azure 




function login-proxy
{  
    $webclient=New-Object System.Net.WebClient
    $credentials = Get-Credential -Message "Proxy Account"
    $webclient.Proxy.Credentials=$credentials
}
