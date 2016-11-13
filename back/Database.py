from flask import Flask
from flask import request, jsonify



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
		
	
	
def dataToJSON(lat,lon,name,it,broken):
	return "{ \"latitude: \""+str(lat)+",\n\"longitude:\" "+str(lon)+",\n\"name:\" \""+name+"\",\n\"broken: \""+str(broken)+"}"

app = Flask(__name__)

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
			lat = float(str(lat)) * (10**6)
			lng = float(str(lng)) * (10**6)
			tempLoc = addLocation(name, lat, lng)
			if tempLoc == None:
				play.isBroken(True)
			else:
				play.setLatLng(tempLoc)
			locDict[name]= play
		else :
			play.isBroken(True)

	return jsonify(name=play.name, it=play.it, broken=play.broken, lat=play.loc.lat, lng=play.loc.lng)	
	#return "{response:\"Welcome"+name+"!\"}" 

def addLocation(name, lat, lng):
	loc = None
	if (lat >= -90000000 and lat <= 90000000) and (lng >= -180000000 and lng <= 180000000):
		loc = LatLng()
		loc.setLat(lat/(10**6))
		loc.setLng(lng/(10**6))
		global locDict
	return loc

@app.route("/allUsers")
def allUsers():
	output = ""
	for key, value in locDict.items():
		output += dataToJSON(lat=value.loc.lat, lon=value.loc.lng, name=value.name, it=value.it, broken=value.broken)
	return output

#@app.route("/update")
#def update():

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























