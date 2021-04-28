---
sidebar_position: 1
title: Giveaway Package (Basic Version) 
sidebase_label: Basic Giveaway Read Me
---

This is a giveaway package for YAGPDB bot consisting of 2 Custom Commands (CCs). Both must be saved for it to work as expected.

---

## Sub-Commands (precede all commands by the prefix for YOUR server to invoke them):

1. `giveaway start <Time> [Prize]`

    Use: To start a new giveaway.
    - `<Time>` It is specified as the amount of time after which giveaway winners will be announced or how long giveaway will be active.  
      Format is (num)y(num)mo(num)w(num)d(num)h(num)m(num)s.
      ```
      eg: 1y7mo2w1d3h4m15s = 1 year 7 months 2 weeks 1 day 3 hours 4 minutes and 15 seconds.
      ```

      **Note:** must not contain spaces in between and use the mentioned format only i.e d not days for specifying days so on.
    
    - `[Prize]` A string which will contain the prize of the giveaway , can be multiple words.

        **Optional Flags:**  
        
        | Flag |    Argument Type     |                                        Usage                                        |
        | ---- | :------------------: | :---------------------------------------------------------------------------------: |
        | -p   |        number        |          for specifying max number of participants( default is unlimited).          |
        | -w   |        number        |                  for specifying number of winners ( default is 1)                   |
        | -c   | Channel (ID/Mention) | for specifying the channel for giveaway to take place ( default is current channel) |

        **Example:** `(prefix)giveaway start 1d12h Ps4 Pro -p 50 -w 2 -c #giveaway-channel` will start a giveaway in the #giveaway-channel which will remain active for 1 day 12 hours with max participants as 50 and max winners as 2.

2. `giveaway end <ID>`
    Ends a giveaway with specified ID and will announce the winners instantly. Will update giveaway announcement message.

    **Note:** ID is the long number which can be obtained using: `g list` command and is also mentioned in the giveaway announcement embed.

3. `giveaway cancel <ID>`
    Cancels a giveaway with specified ID WITHOUT announcing winners. Will update giveaway announcement message.

    **Note:** ID is the long number which can be obtained using: `g list` command and is also mentioned in the giveaway announcement embed.

4. `giveaway list`
Lists all active giveaways with their IDs , Prize and Ending Time.

---

## ExecCC support:
Code has inbuilt intuitive execCC support. ExecData for invoking command via execCC is simply:
```
"giveaway <Sub_Command> <argument_1> <argument_2> ..."
```

#### Examples:
- `{{execCC $CCID_for_giveaway_cc nil 0 "-giveaway start 1d Coins -w 2"}}` is equivalent to: `-giveaway start 1d Coins`  
    Above will start a giveaway in the same channel in which execCC is invoked with a duration of 1 day with max winners: 2 and prize: Coins

- `{{execCC $CCID_for_giveaway_cc nil 0 "-givewaway end 11106339"}}` is equivalent to: `-giveaway end 11106339`  
    Above will end the giveaway with ID = `11106339` immediately and announce the winners.

So in general you can pass the ExecData as simply trigger followed by Sub-Command and arguments separated by a space " " all joined into a single string.

---

## Inbuilt syntax displayer:
The main command also has an inbuilt syntax displayer which can be invoked by simply typing the trigger without any arguments.

---

## Things which can be modified:
The giveaway emoji is present as the Top of both commands and can be modified according to choice but remember!! needs to be modified for both commands (CCs).

---

This custom command was authored by [@Satty9361](https://github.com/Satty9361).