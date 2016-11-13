"""
date: 11-12-2016
author: Richard Joerger & Hank Sheehan
"""

"""
IMportin' stuff
"""
from flask import Flask
from flask import request, jsonify
import json
import ast
import urllib2#for GET requests

global playerList
playerList = []
global it
it = ''
global locDict
locDict = {}

class LatLng:
	def setLat(self, lat):
		self.lat = lat

	def setLng(self, lng):
		self.lng = lng

class Player:
	def setName(self, name):
		self.name = name
	
	def setLatLng(self, loc):
		self.loc = loc

	def setIt(self, it):
		self.it = it

	def isBroken(self, broke):
		self.broken = broke
		



app = Flask(__name__)


"""
adds a player and returns a json with the 5 fields (name, it, broken, lat, lng)
"""
#name=<>&lat=<>&lng=<>
@app.route("/add")
def playerAdd():
	name = request.args.get('name')
	if name != None:
		play = Player()
		play.setName(name)
		play.isBroken(False)
		if len(locDict) == 0:
			global it
			play.setIt(True)			
		else:
			global it
			play.setIt(False)

		lat = request.args.get('lat')
		lng = request.args.get('lng')
		if lat != None and lng != None:
			lat = float(str(lat))
			lng = float(str(lng))
			tempLoc = addLocation(name, lat, lng)
			if tempLoc == None:
				play.isBroken(True)
			else:
				play.setLatLng(tempLoc)
			locDict[name]= play
			playerList.append(play)
		else :
			play.isBroken(True)

	return jsonify(name=play.name, it=play.it, broken=play.broken, lat=play.loc.lat, lng=play.loc.lng)	
	#return "{response:\"Welcome"+name+"!\"}" 


"""
returns a location object if the lat and lng are in range
"""
def addLocation(name, lat, lng):
	loc = None
	if (lat >= -90 and lat <= 90) and (lng >= -180 and lng <= 180):
		loc = LatLng()
		loc.setLat(lat)
		loc.setLng(lng)
		global locDict
	return loc

"""
returns a string of all players
"""
#allUsers
@app.route("/allUsers")
def allUsers():
	playerString = ''
	for key, value in locDict.items():
		playerString += value.name+";"+str(value.loc.lat)+";"+str(value.loc.lng)+";"+str(value.it).lower() + ','
	playerString = playerString[:len(playerString)-1]
	
	return playerString

"""
Updates the locations of all the players and returns the json
"""
#name=<>&lat=<>&lng=<>
@app.route("/update")
def update():
	name = request.args.get('name')
	if name != None:
		play = locDict[name]
		lat = request.args.get('lat')
		lng = request.args.get('lng')
		lat = float(str(lat))
		lng = float(str(lng))
		tempLoc = addLocation(play.name, lat, lng)
		if tempLoc != None:
		#	tempLoc.setLat(lat/(10**6))
		#	tempLoc.setLng(lng/(10**6))
			play.loc = tempLoc
			return jsonify(broken=False, lat=lat, lng=lng)
		else:
			return jsonify(broken=True)

	else:
		return jsonify(broken=True)

"""
Switches with the players who are 'it'
"""
@app.route("/tag")
def tag():
	tagger = request.args.get('tagger')
	tagged = request.args.get('tagged')
	if tagger != None and tagged != None:
		global locDict
		print(tagger + " " + tagged)
		if (tagger in locDict) and (tagged in locDict):
			tagged = locDict[tagged]
			tagger = locDict[tagger]
			tagger.setIt(False)
			tagged.setIt(True)
			return jsonify(it=tagged.name)
		else :
			return jsonify(it="No.")
	return jsonify(it="No.")


"""
Removes a user by returning a json file
"""
@app.route("/remove")
def remove():
	name = request.args.get('name')
	if name != None:
		global locDict
		if name in locDict:
			del locDict[name]
			return jsonify(name=name)
		else :
			return jsonify(name="No.")


"""
creates and returns a json file with an array of restaurants
"""
@app.route("/restaurants")
def restaurants():
	lat = request.args.get('lat')
	lng = request.args.get('lng')
	if lat != None and lng != None:
		lat = float(str(lat))
		lng = float(str(lng))
		locurl = "http://api.tripadvisor.com/api/partner/2.0/map/"+str(lat)+","+str(lng)+"/restaurants?key=caef92fb-2d4c-4341-bdff-c102b7a7f0da"
		print(locurl)
		content = urllib2.urlopen(locurl).read()
		newStr = json.loads(content)["data"]
		print(len(newStr))
		retStr = "{\"places\":["
		for x in range(0,len(newStr)):
			print(newStr[x]["distance"])
			retStr += "{"
			retStr += "\"address\": \""
			retStr += newStr[x]["address_obj"]["street1"]
			retStr += "\",\n"
			retStr += "\"distance\": "
			retStr += "\""+newStr[x]["distance"]
			retStr += "\"\n"
			retStr += "},\n"
		retStr = retStr[:len(retStr)-2]
		retStr += "]}"
		return jsonify(ast.literal_eval(retStr))
	else :
		return jsonify(name="No.")

if __name__ == '__main__':
	app.run(host="0.0.0.0", port=5002)
