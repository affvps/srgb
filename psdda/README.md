---
title: PSD���ļ���������������
date: 2018-8-3
tags:  [cpp]
---

�m��sRGB ��оС�������� ?http://sRGB.vicp.net
	
https://github.com/hongwenjun/psdda

### PSD���ļ���������������

˫�� PSD���ļ��޸�����.bat ��һ�������д���

������ ps �ٰ� TAB�� psdda ������Զ���ȫ �ٰ��¿ո� �� ���ļ������� �� psd �ļ� ����������

���س����й��ߣ�����޸����ļ������ Fix_�ļ���.psd

����PS �� Fix_psd.psd ���һ�£�������С�ļ���

����PS �����BUG�����ܶ������������ݼ�ʹɾ�������Ҳ���ܼ��ٴ�С �����������������

�����ܶ���ϲ�ͼ��
�����ܶ��󵼳����ٵ���Ӧ�þͿ���

![](https://raw.githubusercontent.com/hongwenjun/psdda/master/psdda.gif)

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

size_t get_fileSize(const char* filename);
const char* GetFileBaseName(const char* szPath);
char* memfind(const char* buf, const char* tofind, size_t len);
void helpinfo(void);

int main(int argc, char* argv[])
{
    if (argc == 1) {
        helpinfo();
        return -1;
    }

    const char* filename = argv[1];
    const char* savefile = GetFileBaseName(filename);

    if (argc == 3) {
        savefile = argv[2];
    }

    FILE* psdfile = fopen(filename, "rb");
    if (psdfile == NULL) {
        fputs("File error", stderr);
        exit(1);
    }

    long filesize = get_fileSize(filename);
    size_t result;


    char* buf = new char[filesize];
    result = fread(buf, 1, filesize, psdfile);


    if (filesize > 10 * 1024 * 1024)
        printf("�ļ���С: %d MB\t\t�ļ���:%s\n",  filesize / 1024 / 1024, savefile);
    else
        printf("�ļ���С: %d KB\t\t�ļ���:%s\n",  filesize / 1024 + 1, savefile);

    fclose(psdfile);

    const char* flag_beg = "<photoshop:DocumentAncestors>" ;
    const char* flag_end = "</photoshop:DocumentAncestors>" ;

    char* pch = NULL;
    char* pch2 = NULL;
    size_t pos = 0;
    size_t pos2 = 0;
    bool flag_found = false;

    pch = memfind(buf, flag_beg, result);
    pch2 = memfind(buf, flag_end, result);

    while ((pch != NULL) && (pch2 != NULL)) {

        pos = pch - buf;
        pos2 = pch2 - buf + strlen(flag_end);

        if (pos2 < pos) {
            fputs("File error", stderr);
            exit(1);
        }

        printf("DocumentAncestors�����ֹ: 0x%X  -->  0x%X\n",  pos, pos2);

        memset(pch, ' ', pos2 - pos);   // ����������ݣ�ʹ�ÿո����

        flag_found = true;

        pch = memfind(buf + pos2, flag_beg, result - pos2);
        pch2 = memfind(buf + pos2, flag_end, result - pos2);
    }

    if (!flag_found) {
        fputs("PSD�ļ�û�� DocumentAncestors��ǣ�����Ҫ���� ", stderr);
        exit(1);
    }

    // Ĭ���޸��ļ�����ǰ׺ Fix_
    char fix_name[256];
    if (argc == 2) {
        strcpy(fix_name, "Fix_");
        strcat(fix_name, savefile);
        savefile = fix_name;
    }

    FILE* pFile = fopen(savefile, "wb");
    fwrite(buf, sizeof(char), result, pFile);

    printf("�����������ļ���:\t%s\n�ǵ�Ҫ��PS�򿪱�����ܰ��ļ���С!\n", savefile);

    delete [] buf;
    fclose(pFile);


    return 0;
}




void helpinfo(void)
{
    printf("���������PSD�ļ����������� by �m���� sRGB.vicp.net\n");
    printf("��Դ����    https://github.com/hongwenjun/psdda\n\n");
    printf("Usage: psdda.exe  test.psd  [fix_psd.psd] \n\n");
    printf("���� ֻһ���ļ�������,�Զ���ǰ׺Fix_; ���2���ļ�����ͬ,�����ļ�!\n\n");
}


// ����ļ���С
size_t get_fileSize(const char* filename)
{
    FILE* pfile = fopen(filename, "rb");
    fseek(pfile, 0, SEEK_END);
    size_t size = ftell(pfile);
    fclose(pfile);
    return size;

}


// �õ�ȫ·���ļ����ļ���
const char* GetFileBaseName(const char* szPath)
{
    const char* ret = szPath + strlen(szPath);
    while (!((*ret == '\\') || (*ret == '/'))
            && (ret != (szPath - 1))) // �õ��ļ���
        ret--;
    ret++;
    return ret;
}

// �ڴ�����ַ� memfind
char* memfind(const char* buf, const char* tofind, size_t len)
{
    size_t findlen = strlen(tofind);
    if (findlen > len) {
        return ((char*)NULL);
    }
    if (len < 1) {
        return ((char*)buf);
    }

    {
        const char* bufend = &buf[len - findlen + 1];
        const char* c = buf;
        for (; c < bufend; c++) {
            if (*c == *tofind) { // first letter matches
                if (!memcmp(c + 1, tofind + 1, findlen - 1)) { // found
                    return ((char*)c);
                }
            }
        }
    }

    return ((char*)NULL);
}

```

### �����а汾���� 

[psdda��ִ���ļ�����](https://raw.githubusercontent.com/hongwenjun/psdda/master/psdda.exe)

### Ϊ���ʺϲ���ʹ�ã������˸���ͼ�ν���

https://github.com/hongwenjun/cmd_gui





---
title: ͼ�ν���_PSD���ļ���������������
date: 2018-8-3
tags:  [cpp]
---

�m��sRGB ��оС�������� ?http://sRGB.vicp.net
	
https://github.com/hongwenjun/cmd_gui

### ͼ�ν���_PSD���ļ���������������

ʹ�÷�����ͼ

![](/webp/guida.webp)

### Դ����Ƭ��

���ڳ�����ǽ��ճ������Ͳ�������ϳ�һ��������
Ȼ��ȥ���ص���

```cpp
bool CALLBACK runBtnClick(HELE hEle, HELE hEventEle)
{

    // �ı����д����
    edit_text();

    // ��ʽ��������
    wchar_t wbuf [2 * MAX_PATH] = {0};
    char cmdline[2 * MAX_PATH] = {0};
    swprintf(wbuf, L"\"%s\" \"%s\"  %s\\" , appFile, docFile, fontPath);
    WCHARTochar(cmdline, wbuf);

    MessageBoxA(NULL, cmdline, "ע��: ȷ��Ŀ¼����,�����пո�", MB_OKCANCEL);
    execute_command(cmdline);


    return true;
}


// ִ��������
int execute_command(char* cmdline)
{
    SetConsoleTitle(cmdline);
    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);

    // ��̨����
    si.dwFlags   =   STARTF_USESHOWWINDOW;
    si.wShowWindow   =   SW_HIDE;

    ZeroMemory(&pi, sizeof(pi));
    // Start the child process.
    CreateProcess(NULL, TEXT(cmdline), NULL, NULL, FALSE, 0,
                  NULL, NULL, &si, &pi);
    // Wait until child process exits.
    WaitForSingleObject(pi.hProcess, INFINITE);
    // Get the return value of the child process
    DWORD ret;
    GetExitCodeProcess(pi.hProcess, &ret);
    if (!ret) {
        MessageBoxA(NULL, "PSD���ļ�����������ִ�����!",
                    "(C) ��Ȩ���� 2018.08 Hongwenjun (�m����)", MB_OKCANCEL);
    }
    // Close process and thread handles.
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return ret;
}

```

