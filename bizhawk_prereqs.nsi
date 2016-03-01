!include x64.nsh

; The name of the installer
Name "Bizhawk Prerequisites"

; The file to write
OutFile "bizhawk_prereqs.exe"

; The default installation directory
InstallDir $DESKTOP\Example1

; Request application privileges for Windows Vista+
RequestExecutionLevel admin 

LicenseText "The following prerequisites will be checked and installed:\n(Don't worry, the x64 installers are benign on 32bit systems)" "OK"
LicenseData "dist\info.txt"
Page license
Page instfiles

Section "Windows Imaging Component (.net 4.0 prerequisite for older OS)" SEC_WIC

  SetOutPath "$TEMP"
  File "dist\wic_x86_enu.exe"
  DetailPrint "Running Windows Imaging Component Setup..."
  ExecWait '"$TEMP\wic_x86_enu.exe" /passive /norestart'
  DetailPrint "Finished Windows Imaging Component Setup"
  
  Delete "$TEMP\wic_x86_enu.exe"

done:
SectionEnd

Section "Microsoft Visual C++ 2010 SP1 Runtime" SEC_CRT2010_SP1

  SetOutPath "$TEMP"
  File "dist\vcredist_2010_sp1_x86.exe"
  DetailPrint "Running Visual C++ 2010 SP1 Runtime Setup..."
  DetailPrint "(And ordering it to attempt a repair since some user's DLLs are wrecked)"
  ExecWait '"$TEMP\vcredist_2010_sp1_x86.exe" /repair /q /promptrestart'
  DetailPrint "Finished Visual C++ 2010 SP1 Runtime Setup"
  
  Delete "$TEMP\vcredist_2010_sp1_x86.exe"

done:
SectionEnd

Section "Microsoft Visual C++ 2010 SP1 Runtime (x64)" SEC_CRT2010_SP1_X64

  SetOutPath "$TEMP"
  File "dist\vcredist_2010_sp1_x64.exe"
  DetailPrint "Running Visual C++ 2010 SP1 Runtime (x64) Setup..."
  ExecWait '"$TEMP\vcredist_2010_sp1_x64.exe" /q /promptrestart'
  DetailPrint "Finished Visual C++ 2010 SP1 (x64) Runtime Setup"
  
  Delete "$TEMP\vcredist_2010_sp1_x64.exe"

done:
SectionEnd

Section "Microsoft Visual C++ 2015 Runtime" SEC_CRT2015

  SetOutPath "$TEMP"
  File "dist\vcredist_2015_x86.exe"
  DetailPrint "Running Visual C++ 2015 Runtime Setup..."
  ExecWait '"$TEMP\vcredist_2015_x86.exe" /quiet'
  DetailPrint "Finished Visual C++ 2015 SP1 Runtime Setup"
  
  Delete "$TEMP\vcredist_2015_x86.exe"

done:
SectionEnd

Section "Microsoft Visual C++ 2015 Runtime (x64)" SEC_CRT2015_X64

  SetOutPath "$TEMP"
  File "dist\vcredist_2015_x64.exe"
  DetailPrint "Running Visual C++ 2015 Runtime (x64) Setup..."
  ExecWait '"$TEMP\vcredist_2015_x64.exe" /quiet'
  DetailPrint "Finished Visual C++ 2015 SP1 (x64) Runtime Setup"
  
  Delete "$TEMP\vcredist_2015_x64.exe"

done:
SectionEnd

!define NETVersion "4.0.30319"
!define NETInstaller "dotNetFx40_Full_setup.exe"
Section "MS .NET Framework v${NETVersion}" SecFramework
  IfFileExists "$WINDIR\Microsoft.NET\Framework\v${NETVersion}\mscorlib.dll" NETFrameworkInstalled 0
  File /oname=$TEMP\${NETInstaller} dist\${NETInstaller}
 
  DetailPrint "Starting Microsoft .NET Framework v${NETVersion} Setup..."
  ExecWait '"$TEMP\${NETInstaller}" /passive /norestart'
  Return
 
  NETFrameworkInstalled:
  DetailPrint "Microsoft .NET Framework is already installed!"
 
SectionEnd

Section "DirectX Web Setup" SEC_DIRECTX
                                                                              
 ;SectionIn RO

 SetOutPath "$TEMP"
 File "dist\dxwebsetup.exe"
 DetailPrint "Running DirectX Web Setup..."
 ExecWait '"$TEMP\dxwebsetup.exe" /Q'
 DetailPrint "Finished DirectX Web Setup"                                     
                                                                              
 Delete "$TEMP\dxwebsetup.exe"

SectionEnd