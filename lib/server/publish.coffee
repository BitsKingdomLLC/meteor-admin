Meteor.publishComposite 'adminCollectionDoc', (collection, id) ->
	check collection, String
	check id, Match.OneOf(String, Mongo.ObjectID)
	if Roles.userIsInRole this.userId, ['admin']
		find: ->
			adminCollectionObject(collection).find(id)
		children: AdminConfig?.collections?[collection]?.children or []
	else
		@ready()

Meteor.publish 'adminUsers', ->
	if Roles.userIsInRole @userId, ['admin']
		Meteor.users.find()
	else
		@ready()

Meteor.publish 'adminUser', ->
	Meteor.users.find @userId

Meteor.publish null, ->
	Meteor.roles.find({})
