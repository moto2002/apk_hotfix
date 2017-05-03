#!/usr/bin/python
#encoding=utf-8
import io
import sys
import hashlib
import string
import os
import zipfile
import json
import codecs

def printUsage():
	print ('''Usage: [python] md5_generate.py <dlldir>  <zipfile>''')
def file_extension(path):
    return os.path.splitext(path)[1] 

def md5_str(filename):
    m = hashlib.md5()
    file =io.FileIO(filename,'r')
    bytes = file.read(1024)
    while(bytes != b''):
        m.update(bytes)
        bytes =file.read(1024)
    file.close()
    md5value = m.hexdigest()
    print(md5value+"\t"+filename)
    return md5value
	
def main():
    if(sys.argv.__len__()==3):
        rootdir = sys.argv[1]
        zipdir  = sys.argv[2]
        md5list = [];
        for i in os.listdir(rootdir):
            if os.path.isfile(os.path.join(rootdir,i)) and file_extension(os.path.join(rootdir,i))==".dll":
                dat = i.replace(".dll",".dat");
                size = os.path.getsize(os.path.join(rootdir,i))
                md5 = md5_str(os.path.join(rootdir,i));
                obj = {"name":dat,"md5":md5,"size":size};
                md5list.append(obj)
                os.rename(os.path.join(rootdir,i),os.path.join(rootdir,dat))

        md5file = rootdir+os.sep+"CHECKSUM.json";
        print "generate "+md5file
        if os.path.exists(md5file):
            os.remove(md5file)
        with codecs.open(md5file,'w','utf-8') as json_file:
                json_file.write(json.dumps(md5list,ensure_ascii=False,indent=4).encode('utf-8'))

        if os.path.exists(zipdir):
            os.remove(zipdir)
        z = zipfile.ZipFile(zipdir, 'w', zipfile.ZIP_DEFLATED)
        for i in os.listdir(rootdir):
            ext = file_extension(os.path.join(rootdir,i))
            if os.path.isfile(os.path.join(rootdir,i)) and (ext==".dat" or ext==".json"):
                z.write(os.path.join(rootdir,i),i)
        z.close()
        
        print "dll md5 list generate successful!"
    else:
        printUsage()
        
main()
