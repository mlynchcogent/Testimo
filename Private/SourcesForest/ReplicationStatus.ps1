﻿
$ReplicationStatus = @{
    Enable = $true
    Source = @{
        Name         = 'Forest Replication using RepAdmin'
        Data         = {
            $Header = '"showrepl_COLUMNS","Destination DSA Site","Destination DSA","Naming Context","Source DSA Site","Source DSA","Transport Type","Number of Failures","Last Failure Time","Last Success Time","Last Failure Status"'
            $data = repadmin /showrepl * /csv 
            $data[0] = $Header
            $data | ConvertFrom-Csv
        }
        Details      = [ordered] @{
            Area        = ''
            Description = ''
            Resolution  = ''
            RiskLevel   = 10
            Resources   = @(

            )
        }
        Requirements = @{
            CommandAvailable = 'repadmin'
            OperatingSystem  = '*2008*'
        }
    }
    Tests  = [ordered] @{
        ReplicationTests = @{
            Enable     = $true
            Name       = 'Replication Test'
            Parameters = @{
                ExpectedValue         = 0
                Property              = 'Number of Failures'
                OperationType         = 'eq'
                PropertyExtendedValue = 'Last Success Time'
                OverwriteName         = { "Replication from $($_.'Source DSA') to $($_.'Destination DSA'), Naming Context: $($_.'Naming Context')" }
            }
        }
    }
}