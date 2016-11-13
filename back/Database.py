"""
author: Richard Joerger & Hank Sheehan
"""

"""
IMportin' stuff
"""
from flask import Flask
from flask import request, jsonify
import json



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
		
	
	
def dataToJSON(lat,lng,name,it):
	return name+";"+str(lat)+";"+str(lng)+";"+str(it).lower()

app = Flask(__name__)


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

def addLocation(name, lat, lng):
	loc = None
	if (lat >= -90 and lat <= 90) and (lng >= -180 and lng <= 180):
		loc = LatLng()
		loc.setLat(lat)
		loc.setLng(lng)
		global locDict
	return loc

#allUsers
@app.route("/allUsers")
def allUsers():
	playerString = ''
	for key, value in locDict.items():
		playerString += dataToJSON(lat=value.loc.lat, lng=value.loc.lng, name=value.name, it=value.it) + ','
	playerString = playerString[:len(playerString)-1]
	
	return playerString

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


if __name__ == '__main__':
	app.run(host="0.0.0.0")


"""""""""""""""""
{
	players = 
		{
			player_1 =
				{


				}		

		}


}
"""""""""""""""























