import logging

from flask import Flask #for basic flask server
from flask import request #for url parameters


app = Flask(__name__)

#Sent to the server when the user wants to join the global game
#Returns: their username
@app.route('/adduser')
def adding():
	uname = request.args.get('username')#Gets their username
	if uname == None:
		return badReturnError("Invalid Username")
	return "{response:\"Welcome"+uname+"!\"}"

#Sent to the server when the user wants to know who is "it"
#Returns: their username
@app.route('/it')
def whoit():
	return 'Hello World!'

#Sent to the server when the user wants to know the location of all players
#Returns: A json formatted String of all of the users and their locations
@app.route('/loc')
def getLocation():
	retStr = "{response:\""
	#for loop for whatever data type is used
		#retStr += "loc"
	retStr + "\"}"
	return retStr

@app.errorhandler(500)
def server_error(e):
	# Log the error and stacktrace.
	logging.exception('An error occurred during a request.')
	return 'An internal error occurred.', 500

def badReturnError(errstr):
	return "{ errortitle: \""+errstr+"\""}"