class MBHWeapon extends UTWeapon
	abstract;

var() float ReloadTime;
var MBHPlayerController thePlayer;
var MBHHud theHud;
var int weaponHudIndex;

simulated function PostBeginPlay()
{
	local MBHPlayerController PC;

	super.PostBeginPlay();

	foreach LocalPlayerControllers(class'MBHPlayerController', PC)
	{
		if(PC.Pawn != none)
		{
			thePlayer = PC;
		}
	}
}

simulated function Activate()
{
	super.Activate();

	thePlayer.activeWeaponIndex = weaponHudIndex;
	thePlayer.activeWeapon = self;
}

exec function Reload()
{
	//AddAmmo(MaxAmmoCount);

	ForceEndFire();
	SetTimer(ReloadTime, false, 'AddMaxAmmo');
}

function AddMaxAmmo()
{
	AddAmmo(MaxAmmoCount);
}


function ClearReloadTimer()
{
	ClearTimer('AddMaxAmmo');
}




//simulated function float GetWeaponRating()
//{
//	if( InvManager != None )
//	{
//		return InvManager.GetWeaponRatingFor( Self );
//	}

//	//if( !HasAnyAmmo() )
//	//{
//	//	return -1;
//	//}

//	return 1;
//}

simulated function WeaponEmpty()
{
	// If we were firing, stop
	if ( IsFiring() )
	{
		GotoState('Active');
	}

        // This is the code that switches to another weapon when it has no ammo
	//if ( Instigator != none && Instigator.IsLocallyControlled() )
	//{
	//	Instigator.InvManager.SwitchToBestWeapon( true );
	//}
}

DefaultProperties
{
	ReloadTime=1.0
	bNeverForwardPendingFire=true
	weaponHudIndex=-1
}
