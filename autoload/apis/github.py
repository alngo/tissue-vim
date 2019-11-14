import vim
import re

def extractValueFromKey(key, res):
    match = re.search('"{}": "(.*)"'.format(key), res, re.IGNORECASE)
    if match:
        message = match.group(1)
        return (message)
    else:
        return ("")

def checkAuthentification():
    res = vim.eval("l:res")
    msg = extractValueFromKey("message", res)
    login = extractValueFromKey("login", res)
    if (login):
        print("Authenticated !")
        vim.command("let g:tissue_authenticated = 1")
    else:
        print(msg)
