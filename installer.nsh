!include FileFunc.nsh
!include StrFunc.nsh
!include LogicLib.nsh

!macro customInit
    IfFileExists "$TEMP\remoteit.log" custom_init_log_found custom_init_log_not_found
    custom_init_log_found:
        FileOpen $8 "$TEMP\remoteit.log" a
        FileSeek $8 0 END
        goto custom_init_log_end
    custom_init_log_not_found:
        FileOpen $8 "$TEMP\remoteit.log" w
    custom_init_log_end:
    FileWrite $8 "$\r$\n$\r$\n________________________________________________$\r$\n"
    FileWrite $8 "Init electron test (${__DATE__} ${__TIME__})$\r$\n"

    FileClose $8
!macroend

!macro customInstall
    IfFileExists "$TEMP\remoteit.log" file_found file_not_found
    file_found:
        FileOpen $8 "$TEMP\remoteit.log" a
        FileSeek $8 0 END
        goto log_file_end
    file_not_found:
        FileOpen $8 "$TEMP\remoteit.log" w
    log_file_end:
    FileWrite $8 "$\r$\nInstall electron test (${__DATE__} ${__TIME__})$\r$\n"
    FileWrite $8 "Installing Service$\r$\n"    

    FileWrite $8 "$\r$\nEnd Install $\r$\n$\r$\n"
    FileClose $8
!macroend

!macro customRemoveFiles
    IfFileExists "$TEMP\remoteit.log" file_found_u file_not_found_u
    file_found_u:
        FileOpen $8 "$TEMP\remoteit.log" a
        FileSeek $8 0 END
        goto end_of_test_u ;<== important for not continuing on the else branch
    file_not_found_u:
        FileOpen $8 "$TEMP\remoteit.log" w
    end_of_test_u:
    FileWrite $8 "$\r$\nStart Remove Files electron test (${__DATE__} ${__TIME__})$\r$\n"

    ; Detect auto-update
    ${If} ${IsUpdated}
        FileWrite $8 "$\r$\nIs an update, don't remove config.$\r$\n"
    ${Else}
        FileWrite $8 "$\r$\nUninstall, remove config.$\r$\n"
    ${endif}

    FileWrite $8 "$\r$\nUninstalling...$\r$\n"

    FileWrite $8 "$\r$\nRemoving installation directories... $\r$\n"
    FileWrite $8 "RMDir $INSTDIR$\r$\n"
    RMDir /r "$INSTDIR"
    FileWrite $8 "DONE$\r$\n"

    FileWrite $8 "$\r$\nEnd Remove Files$\r$\n"
    FileClose $8 
!macroend