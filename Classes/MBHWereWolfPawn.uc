class MBHWereWolfPawn extends MBHEnemyPawn
	placeable ClassGroup(MonsterBountyHunter);

var int maxHealth;

function PostBeginPlay()
{
	super(UDKPawn).PostBeginPlay();
	maxHealth = Health;
}

event TakeDamage(int DamageAmount, Controller EventInstigator, 
	vector HitLocation, vector Momentum,
class<DamageType> DamageType,
	optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	super.TakeDamage(DamageAmount,EventInstigator,HitLocation,Momentum,DamageType,HitInfo,DamageCauser);

	isAngry = true;
}

DefaultProperties
{
	Begin Object Name=CollisionCylinder
		CollisionHeight=+88.000000
	End Object

	/*Begin Object Class=SkeletalMeshComponent Name=WofPawnSkeletalMesh
		SkeletalMesh=StaticMesh'MBHGameModels.Enemies.Werewolf'
		AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
		HiddenGame=FALSE
		HiddenEditor=FALSE
		Scale3D=(X=2.0,Y=2.0,Z=2.0)
	End Object

	Mesh=WofPawnSkeletalMesh

	Components.Add(WofPawnSkeletalMesh)*/
	ControllerClass=class'MonsterBountyHunter.MBHWereWolfAIController'

	GroundSpeed=900;

	bJumpCapable=false
	bCanJump=false

	bumpDamage=100.0
	followDistance=2000.0
	meleeAttackDistance=96.0
	isAngry=false
}