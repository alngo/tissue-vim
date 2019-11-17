import vim
import re
import json

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
