.class public Lcom/motorola/groundloopnoisepreventer/IntroActivity;
.super Landroid/app/Activity;
.source "IntroActivity.java"


# instance fields
.field private mServiceStarter:Lcom/motorola/groundloopnoisepreventer/ServiceStarter;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 17
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 18
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/motorola/groundloopnoisepreventer/IntroActivity;->mServiceStarter:Lcom/motorola/groundloopnoisepreventer/ServiceStarter;

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 22
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 23
    const/high16 v1, 0x7f030000

    invoke-virtual {p0, v1}, Lcom/motorola/groundloopnoisepreventer/IntroActivity;->setContentView(I)V

    .line 24
    new-instance v1, Lcom/motorola/groundloopnoisepreventer/ServiceStarter;

    invoke-direct {v1}, Lcom/motorola/groundloopnoisepreventer/ServiceStarter;-><init>()V

    iput-object v1, p0, Lcom/motorola/groundloopnoisepreventer/IntroActivity;->mServiceStarter:Lcom/motorola/groundloopnoisepreventer/ServiceStarter;

    .line 26
    iget-object v1, p0, Lcom/motorola/groundloopnoisepreventer/IntroActivity;->mServiceStarter:Lcom/motorola/groundloopnoisepreventer/ServiceStarter;

    invoke-virtual {v1, p0}, Lcom/motorola/groundloopnoisepreventer/ServiceStarter;->isPowerConnected(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 28
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/motorola/groundloopnoisepreventer/SilenceService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 29
    .local v0, "serviceIntent":Landroid/content/Intent;
    const-string v1, "com.motorola.groundloopnoisepreventer.action.CHARGER_CONNECTED"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 30
    invoke-virtual {p0, v0}, Lcom/motorola/groundloopnoisepreventer/IntroActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 32
    .end local v0    # "serviceIntent":Landroid/content/Intent;
    :cond_0
    return-void
.end method
