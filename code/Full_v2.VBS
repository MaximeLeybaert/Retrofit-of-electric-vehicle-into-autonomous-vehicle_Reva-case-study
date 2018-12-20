
Option Explicit  'Forces the explicit declaration of all the variables in a script.
Call Data.Root.ChannelGroups.Add("Converted", 2).Activate()
Call Data.Root.ChannelGroups.Add("Filtered", 3)

Call ChnClpCopy("[1]/Batt V")
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(2).Channels("Batt V"),Data.Root.ChannelGroups(2).Channels,1)
Call Calculate("ch(""[2]/Batt V"") = ch(""[2]/Batt V"") *50")

Call ChnClpCopy("[1]/Roller Speed")
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(2).Channels("Roller Speed"),Data.Root.ChannelGroups(2).Channels,1)
Call Calculate("ch(""[2]/Roller Speed"") = ch(""[2]/Roller Speed"") * 20 *5.2 * 0.159 * 3.6")
Set ChnResult = ChnRMS("","[2]/Roller Speed","/Roller Speed",1)

Call ChnClpCopy("[1]/Roller Torque")
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(2).Channels("Roller Torque"),Data.Root.ChannelGroups(2).Channels,1)
Call Calculate("ch(""[2]/Roller Torque"") = ch(""[2]/Roller Torque"") * 941 * 0.159")


Call ChnClpCopy("[1]/Batt I")
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(2).Channels("Batt I"),Data.Root.ChannelGroups(2).Channels,1)
Call Calculate("ch(""[2]/Batt I"") = ch(""[2]/Batt I"") *200")

Call ChnClpCopy("'[1]/Phase V', '[1]/Phase I'")
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(2).Channels("Phase V"),Data.Root.ChannelGroups(2).Channels,1)
Call Data.Move(Data.Root.ChannelGroups(2).Channels("Phase I"),Data.Root.ChannelGroups(2).Channels,2)
Call Calculate("ch(""[2]/Phase I"") = ch(""[2]/Phase I"") * 1000")
Call Calculate("ch(""[2]/Phase V"") = ch(""[2]/Phase V"") * 100")

Call ChnClpCopy("[2]/Batt V")
Call Data.Root.ChannelGroups(3).Activate()
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(3).Channels("Batt V"),Data.Root.ChannelGroups(3).Channels,1)
Call Data.Root.ChannelGroups(2).Activate()
Set ChnResult = ChnSmooth("[3]/Batt V","[3]/Batt V",12,"maxNumber","byMeanValue")
Call ChnClpCopy("[2]/Batt I")
Call Data.Root.ChannelGroups(3).Activate()
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(3).Channels("Batt I"),Data.Root.ChannelGroups(3).Channels,1)
Call Data.Root.ChannelGroups(2).Activate()
Set ChnResult = ChnSmooth("[3]/Batt I","[3]/Batt I",100,"maxNumber","byMeanValue")

Call ChnClpCopy("[2]/Roller Torque")
Call Data.Root.ChannelGroups(3).Activate()
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(3).Channels("Roller Torque"),Data.Root.ChannelGroups(3).Channels,1)
Call Data.Root.ChannelGroups(2).Activate()
Set ChnResult = ChnSmooth("[3]/Roller Torque","[3]/Roller Torque",50,"maxNumber","byMeanValue")

Call ChnClpCopy("'[2]/Phase I', '[2]/Phase V'")
Call Data.Root.ChannelGroups(3).Activate()
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(3).Channels("Phase I"),Data.Root.ChannelGroups(3).Channels,1)
Call Data.Move(Data.Root.ChannelGroups(3).Channels("Phase V"),Data.Root.ChannelGroups(3).Channels,2)
Call Data.Root.ChannelGroups(2).Activate()
Set ChnResult = ChnRMS("","[3]/Phase I","[3]/Phase I",1)
Set ChnResult = ChnRMS("","[3]/Phase V","[3]/Phase V",1) 


Data.Root.ChannelGroups(1).Channels("Pedal signal").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(1).Channels("Batt V").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(1).Channels("Batt I").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(1).Channels("Roller Torque").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(1).Channels("Phase V").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(1).Channels("Phase I").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(1).Channels("Roller Speed").Properties("unit_string").Value = "V"


Data.Root.ChannelGroups(2).Channels("Roller Speed").Properties("unit_string").Value = "km/h"
Data.Root.ChannelGroups(2).Channels("Batt V").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(2).Channels("Batt I").Properties("unit_string").Value = "A"
Data.Root.ChannelGroups(2).Channels("Roller Torque").Properties("unit_string").Value = "Nm"
Data.Root.ChannelGroups(2).Channels("Phase V").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(2).Channels("Phase I").Properties("unit_string").Value = "A"


Data.Root.ChannelGroups(3).Channels("Batt V").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(3).Channels("Batt I").Properties("unit_string").Value = "A"
Data.Root.ChannelGroups(3).Channels("Roller Torque").Properties("unit_string").Value = "Nm"
Data.Root.ChannelGroups(3).Channels("Phase V").Properties("unit_string").Value = "V"
Data.Root.ChannelGroups(3).Channels("Phase I").Properties("unit_string").Value = "A"


Data.Root.ChannelGroups(3).Channels("Phase I").Name = "Phase I RMS"
Data.Root.ChannelGroups(3).Channels("Phase V").Name = "Phase V RMS"
Data.Root.ChannelGroups(3).Channels("Batt I").Name = "Batt I Filtered"
Data.Root.ChannelGroups(3).Channels("Batt V").Name = "Batt V Filtered"


Call Data.Root.ChannelGroups.Add("Power", 4).Activate()
Set ChnResult = ChnMul("[2]/Batt V","[2]/Batt I","/Multiplied")
Data.Root.ChannelGroups(4).Channels("Multiplied").Name = "Battery Power"
Set ChnResult = ChnSmooth("[4]/Battery Power","/Battery Power",200,"maxNumber","byMeanValue")


Dim MyFolders()
Call InitMyFolders

Sub InitMyFolders
  ReDim MyFolders(1)
  MyFolders(0)="C:\Users\maxim\Documents\REVA_Roller_Bench_Data_Result\diadem_process\"
End Sub

Call View.LoadLayout(MyFolders(0)&"Global_view_curvesTDV.TDV")



Set ChnResult = ChnFiltCalc("","[3]/Roller Torque","/FilteredSignal","IIR","Bessel","Low pass",2,0.5,0,0,1.2,25,"Hamming",0,0)
Data.Root.ChannelGroups(4).Channels("FilteredSignal").Name = "Roller_Torque_Lowpassed"
Call ChnClpCopy("[4]/Roller_Torque_Lowpassed")
Call ChnDelete("[4]/Roller_Torque_Lowpassed")
Call Data.Root.ChannelGroups(3).Activate()
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(3).Channels("Roller_Torque_Lowpassed"),Data.Root.ChannelGroups(3).Channels,1)
Call Data.Root.ChannelGroups(4).Activate()
Call Data.Root.ChannelGroups(3).Activate()
Set ChnResult = ChnFiltCalc("","[1]/Pedal signal","/FilteredSignal","IIR","Bessel","Low pass",2,2,0,0,1.2,25,"Hamming",0,0)
Data.Root.ChannelGroups(3).Channels("FilteredSignal").Name = "Pedal_signal_Lowpassed"

Set ChnResult = ChnFiltCalc("","[2]/Batt V","/FilteredSignal","IIR","Bessel","Low pass",2,0.8,0,0,1.2,25,"Hamming",0,0)
Data.Root.ChannelGroups(3).Channels("FilteredSignal").Name = "Battery Voltage Lowpassed"


Call ChnClpCopy("[2]/Batt I")
Call ChnClpPaste(8)
Call Data.Move(Data.Root.ChannelGroups(3).Channels("Batt I"),Data.Root.ChannelGroups(3).Channels,1)
Data.Root.ChannelGroups(3).Channels("Batt I").Name = "Battery Current Lowpassed"
Set ChnResult = ChnFiltCalc("","[3]/Battery Current Lowpassed","/Battery Current Lowpassed","IIR","Bessel","Low pass",2,0.5,0,0,1.2,25,"Hamming",0,0)
Call Data.Root.ChannelGroups(4).Activate()
Set ChnResult = ChnMul("[3]/Battery Voltage Lowpassed","[3]/Battery Current Lowpassed","/Multiplied")
Data.Root.ChannelGroups(4).Channels("Multiplied").Name = "Battery Power Lowpassed"
Call Data.Root.ChannelGroups(3).Activate()
Set ChnResult = ChnFiltCalc("","[3]/Roller Torque","/Roller Torque","IIR","Bessel","Low pass",2,0.5,0,0,1.2,25,"Hamming",0,0)
Call Data.Root.ChannelGroups(4).Activate()
Set ChnResult = ChnMul("[3]/Roller Torque","[2]/Roller Speed","/Multiplied")
Data.Root.ChannelGroups(4).Channels("Multiplied").Name = "Mechanical Power"
Data.Root.ChannelGroups(4).Channels("Mechanical Power").Name = "Mechanical Power"
Call Calculate("ch(""[4]/Mechanical Power"") = ch(""[4]/Mechanical Power"") /(3.6 * 0.159)")
Set ChnResult = ChnDiv("[4]/Mechanical Power","[4]/Battery Power Lowpassed","/Divided")
Data.Root.ChannelGroups(4).Channels("Divided").Name = "Global efficency"  
