
# Script to Change Daily wallpaper

Function Set-WallPaper($Image) {
<#
 
    .SYNOPSIS
    Applies a specified wallpaper to the current user's desktop
    
    .PARAMETER Image
    Provide the exact path to the image
  
    .EXAMPLE
    Set-WallPaper -Image "C:\Wallpaper\Default.jpg"
  
#>
  
Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
  
public class Params
{ 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);
}
"@ 
  
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
  
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
 
}

$response = Invoke-RestMethod -Uri "https://api.unsplash.com/photos/random/?client_id=qEu5nx4ETtDueAZKUFZnhU9TgWi2Sbbrz8bGEgEmcwY&orientation=landscape"
$response.urls

Invoke-WebRequest -Uri $response.urls.full -OutFile C:\Users\harshu\Downloads\wallOChangeDir\test.jpg -UseBasicParsing
Set-WallPaper("C:\Users\harshu\Downloads\wallOChangeDir\test.jpg")

exit