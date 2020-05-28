#!/usr/bin/env python
# -*- coding:UTF-8

'''
Created on 2012-03-14

@author: tangcheng
'''

import sys
import os
import traceback
import time
import py_compile 
import subprocess


c_source_header = '''
#include <Python.h>
#include <marshal.h>
'''

c_source_content = '''
int main(int argc, char *argv[])
{
    int file_size;
    PyCodeObject *pycode;
    PyObject *mainmodule, *maindict;

    Py_Initialize();
    PySys_SetArgv(argc, argv);    
    mainmodule = PyImport_AddModule("__main__");
    maindict = PyModule_GetDict(mainmodule);
    pycode = (PyCodeObject *)PyMarshal_ReadObjectFromString(g_codebuf+8, g_file_size-8);
    PyEval_EvalCode(pycode, maindict, maindict);
    PyErr_Clear();
    Py_Finalize();
    return 0;
}
'''


def main():
    if len(sys.argv) !=3 :
        print("Usage: %s <pyfile> <exefile>"  % sys.argv[0])
        sys.exit(1)

    try:
        mimeType = subprocess.Popen("/usr/bin/file -b --mime-type %s" % sys.argv[1], 
            shell=True, stdout=subprocess.PIPE).communicate()[0].strip()

        if not mimeType == 'application/octet-stream':
            py_compile.compile(sys.argv[1])
            pycFileName = sys.argv[1]+'c'
        else:
            pycFileName = sys.argv[1]

        f = file(pycFileName, 'r')
        pycode = f.read()
        f.close()
    except Exception as e:
        print(str(e))
        sys.exit(1)

    file_len = len(pycode)
    cnt = file_len / 16
    if file_len % 16:
        cnt = cnt + 1
    lines = []
    for i in range(cnt):
        cells = [ ("0x%02x" % ord(k)) for k in pycode[i*16:(i+1)*16] ]
        lines.append(','.join(cells))
    content = ',\n'.join(lines)

    cfile = file(sys.argv[2]+'.c', 'w')
    cfile.write(c_source_header)
    cfile.write("static int g_file_size = %d;\n" % file_len)
    cfile.write("static char g_codebuf[] = {%s};\n" % content)
    cfile.write(c_source_content)
    cfile.close()
    cmd = 'gcc -I/usr/include/python2.6 -lpython2.6 %s.c -o %s' % (sys.argv[2], sys.argv[2])
    print("Run: %s" % cmd)
    os.system(cmd)
 
if __name__ == "__main__":
    main()

