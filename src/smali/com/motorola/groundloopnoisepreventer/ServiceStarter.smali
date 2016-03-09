.class public Lcom/motorola/groundloopnoisepreventer/ServiceStarter;
.super Landroid/content/BroadcastReceiver;
.source "ServiceStarter.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public isPowerConnected(Landroid/content/Context;)Z
    .locals 6
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x1

    .line 62
    const/4 v1, -0x1

    .line 63
    .local v1, "pluggedIn":I
    const/4 v3, 0x0

    new-instance v4, Landroid/content/IntentFilter;

    const-string v5, "android.intent.action.BATTERY_CHANGED"

    invoke-direct {v4, v5}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v3, v4}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    move-result-object v0

    .line 65
    .local v0, "intent":Landroid/content/Intent;
    const-string v3, "plugged"

    const/4 v4, -0x1

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    .line 66
    if-eq v1, v2, :cond_0

    const/4 v3, 0x2

    if-ne v1, v3, :cond_1

    :cond_0
    :goto_0
    return v2

    :cond_1
    const/4 v2, 0x0

    goto :goto_0
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v6, 0x2

    .line 23
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 25
    .local v0, "action":Ljava/lang/String;
    const-string v5, "android.intent.action.ACTION_POWER_CONNECTED"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 27
    new-instance v4, Landroid/content/Intent;

    const-class v5, Lcom/motorola/groundloopnoisepreventer/SilenceService;

    invoke-direct {v4, p1, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 28
    .local v4, "serviceIntent":Landroid/content/Intent;
    const-string v5, "com.motorola.groundloopnoisepreventer.action.CHARGER_CONNECTED"

    invoke-virtual {v4, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 29
    invoke-virtual {p1, v4}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 59
    .end local v4    # "serviceIntent":Landroid/content/Intent;
    :cond_0
    :goto_0
    return-void

    .line 30
    :cond_1
    const-string v5, "android.intent.action.ACTION_POWER_DISCONNECTED"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 32
    new-instance v4, Landroid/content/Intent;

    const-class v5, Lcom/motorola/groundloopnoisepreventer/SilenceService;

    invoke-direct {v4, p1, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 33
    .restart local v4    # "serviceIntent":Landroid/content/Intent;
    const-string v5, "com.motorola.groundloopnoisepreventer.action.CHARGER_DISCONNECTED"

    invoke-virtual {v4, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 34
    invoke-virtual {p1, v4}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    .line 35
    .end local v4    # "serviceIntent":Landroid/content/Intent;
    :cond_2
    const-string v5, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 37
    invoke-virtual {p0, p1}, Lcom/motorola/groundloopnoisepreventer/ServiceStarter;->isPowerConnected(Landroid/content/Context;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 38
    new-instance v4, Landroid/content/Intent;

    const-class v5, Lcom/motorola/groundloopnoisepreventer/SilenceService;

    invoke-direct {v4, p1, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 39
    .restart local v4    # "serviceIntent":Landroid/content/Intent;
    const-string v5, "com.motorola.groundloopnoisepreventer.action.CHARGER_CONNECTED"

    invoke-virtual {v4, v5}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 40
    invoke-virtual {p1, v4}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    .line 42
    .end local v4    # "serviceIntent":Landroid/content/Intent;
    :cond_3
    const-string v5, "disabledandroid.intent.action.PRE_BOOT_COMPLETED"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 44
    new-instance v2, Landroid/content/ComponentName;

    const-class v5, Lcom/motorola/groundloopnoisepreventer/IntroActivity;

    invoke-direct {v2, p1, v5}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 45
    .local v2, "introActivity":Landroid/content/ComponentName;
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    .line 46
    .local v3, "pm":Landroid/content/pm/PackageManager;
    if-eqz v3, :cond_0

    .line 47
    invoke-virtual {v3, v2}, Landroid/content/pm/PackageManager;->getComponentEnabledSetting(Landroid/content/ComponentName;)I

    move-result v1

    .line 48
    .local v1, "enabledSetting":I
    if-eq v1, v6, :cond_0

    .line 49
    const/4 v5, 0x1

    invoke-virtual {v3, v2, v6, v5}, Landroid/content/pm/PackageManager;->setComponentEnabledSetting(Landroid/content/ComponentName;II)V

    goto :goto_0
.end method
