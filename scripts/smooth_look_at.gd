extends Node


#==================================================
# SmoothLookAt Function
#==================================================
#    smoothLookAtRigid -> Call from integrate_forces()
#    smoothLookAt for KinematicBody2D -> Call from _physics_process()
#    smoothLookAt for Node2D -> Call from _process()
#    ----------
#    nodeToTurn = the node you want to turn
#    targetPosition = the target position (Vector2) you want your nodeToTurn to face
#    turnSpeed = how long it will take nodeToTurn to face the direction you want it to face
#    ----------
#    X+ is assumed to be forward, the face/nose of your object

static func smoothLookAt(nodeToTurn, targetPosition, turnSpeed):
	nodeToTurn.transform = nodeToTurn.transform.interpolate_with(Transform2D(targetPosition.angle_to_point(nodeToTurn.position), nodeToTurn.position), turnSpeed)

static func smoothLookAtRigid(nodeToTurn, targetPosition, turnSpeed):
	var target = targetPosition.angle_to_point(nodeToTurn.position)
	nodeToTurn.angular_velocity = (fposmod(target - nodeToTurn.rotation + PI, TAU) - PI) * turnSpeed
