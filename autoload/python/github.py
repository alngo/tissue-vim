import vim
import re
import json

def goToBuffer(target):
    b = vim.eval('bufnr("%s")' % target)
    w = int(vim.eval('bufwinnr(%d)' % int(b)))
    vim.command('%dwincmd w' % w)

def getKeyValue(key, res):
    try:
        return res[key]
    except:
        return None

def checkAuth():
    res = json.loads(vim.eval("l:res"))
    msg = getKeyValue("message", res)
    login = getKeyValue("login", res)
    if (login):
        print("Authenticated !")
        vim.command('let g:tissue_authenticated = 1')
    else:
        print(msg)

def formatLabels(labels):
    return ("")

def formatIssues(issues):
    buf = []
    for issue in issues:
        labels = ""
        line1 = "* " + issue["title"] + " " + labels
        line2 = "| " + "#" + str(issue["number"]) + " " + issue["state"] + \
                " by " + issue["user"]["login"]
        buf.append(line1)
        buf.append(line2)
        buf.append("| ")
    buf.append("_")
    return buf

def printIssues(buf):
    target = vim.eval("g:tissue_buf_name")
    goToBuffer(target)
    vim.command('setlocal modifiable')
    vim.current.buffer[:] = buf
    vim.command('setlocal nomodifiable')

def listIssues():
    res = json.loads(vim.eval("l:res"))
    buf = formatIssues(res)
    printIssues(buf)
