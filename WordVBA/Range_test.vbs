Sub line_paste()


'  ����ת��ճ��

    Range("E2:E7").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("F2").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=True
   
    Range("E8:E14").Select
    Application.CutCopyMode = False
    Selection.Copy
    Range("F8").Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=True
        
End Sub


Sub line_paste2()


'  ����ת��ճ��
    
    
    cell = "E2:E7"

    Range(cell).Select
    Application.CutCopyMode = False
    Selection.Copy
    
    ' ѡ����ѡһ����Ԫ��ƫ��1��
    Range(cell).Resize(1).Offset(0, 1).Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=True

End Sub

Function find_range_paste(cell As String)

'  ����ת��ճ�� ����

    Range(cell).Select
    Application.CutCopyMode = False
    Selection.Copy
    
    ' ѡ����ѡһ����Ԫ��ƫ��1��
    Range(cell).Resize(1).Offset(0, 1).Select
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:= _
        False, Transpose:=True

End Function


Sub ��Ԫ�񼯺ϲ���()
    Dim input_data As String
    ' ������Ҫת�������ĵ�Ԫ�񼯺�
    
    input_data = "E1:E1,E2:E7,E8:E14,E15:E19,E20:E27"
    
    ' ��Ԫ�񼯺��и���ַ������飬
    arr = Split(input_data, ",")
    
    ' ��Ԫ����ú���
    find_range_paste (arr(4))
    
    ' �������飬���ú���
    For Each i In arr
        find_range_paste (i)
    Next
    
End Sub




Sub range_test()
    Dim input_data As String
    
    input_data = "E1:E1,E2:E7,E8:E14,E15:E19,E20:E27"
    arr = Split(input_data, ",")
    
    
    Range(arr(4)).Select
    Range(arr(4)) = "Range��Ԫ��"
    
End Sub




