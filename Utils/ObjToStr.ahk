#Requires AutoHotkey v2.0

StringifyAsJSON(Obj) {
    FormatedString := ""

    if Obj is Array {
        FormatedString := StringifyArray(Obj)
    }

    if IsObject(Obj) and !(Obj is Array) {
        FormatedString := StringifyObject(Obj)
    }

    FileAppend "`n", A_WorkingDir "\NewTextFile.txt"
    FileAppend FormatedString . "`n", A_WorkingDir "\NewTextFile.txt"
}

StringifyObject(Obj) {
    FormatedString := '{'

    for ObjKey, ObjValue in Obj.OwnProps() {
        if IsObject(ObjValue) and !(ObjValue is Array) {
            FormatedString .= ' "' . ObjKey . '": ' . StringifyObject(ObjValue)
        }

        if ObjValue is Array {
            FormatedString .= ' "' . ObjKey . '": ' . StringifyArray(ObjValue)
        }

        if ObjValue is Integer or ObjValue is String {
            FormatedString .= ' "' . ObjKey . '":' . ' "' . ObjValue . '"'
        }

        if A_Index != ObjOwnPropCount(Obj) {
            FormatedString .= ","
        }
    }

    FormatedString .= ' }'

    return FormatedString
}

StringifyArray(Arr) {
    FormatedString := '[ '

    Loop Arr.Length {
        if IsObject(Arr[A_Index]) and !(Arr[A_Index] is Array) {
            FormatedString .= StringifyObject(Arr[A_Index])
        }

        if Arr[A_Index] is Array {
            FormatedString .= StringifyArray(Arr[A_Index])
        }

        if Arr[A_Index] is Integer or Arr[A_Index] is String {
            FormatedString .= Arr[A_Index]
        }

        if A_Index != Arr.Length {
            FormatedString .= ", "
        }
    }

    FormatedString .= ' ]'

    return FormatedString
}
