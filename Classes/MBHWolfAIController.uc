class MBHWolfAIController extends AIController;

var Pawn thePlayer;
var MBHWolfPawn thePawn;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
	super.Possess(inPawn, bVehicleTransition);
	Pawn.SetMovementPhysics();
	if(MBHWolfPawn(Pawn) == none)
		`log("Warning: Pawn is not MBHWolfPawn!");
	else
		thePawn = MBHWolfPawn(Pawn);
}

function Tick( float DeltaTime )
{
	local PlayerController PC;

	if(thePlayer == none)
	{
		foreach LocalPlayerControllers(class'PlayerController', PC)
		{
			if(PC.Pawn != none)
			{
				thePlayer = PC.Pawn;
				`log("My enemy is:" @ thePlayer);
			}
		}
	}
	else if(VSize(thePawn.Location - thePlayer.Location) < thePawn.FollowDistance || thePawn.isAngry)
	{
		if(VSize(thePawn.Location - thePlayer.Location) < thePawn.AttackDistance)
		{
			GoToState('');
			thePlayer.Bump(thePawn, CollisionComponent, vect(0,0,0));
		}
		else
		{
			GoToState('FollowingPlayer');
			thePawn.warnOthers();
		}
	}
}

state FollowingPlayer
{
Begin:
	if(thePlayer != none)
	{
		if(thePlayer.Health <= 0)
		{
			thePlayer = none;
			MoveTo(thePawn.startPosition,,,true);
			thePawn.isAngry = false;
			GoToState('');
		}
		else
			MoveToward(thePlayer, thePlayer,thePawn.AttackDistance-40,,false);
	}
	else
		GoToState('');
	GoTo('Begin');
}

defaultproperties
{
}