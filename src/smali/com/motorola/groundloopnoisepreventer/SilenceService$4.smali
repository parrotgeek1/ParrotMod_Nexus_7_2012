.class Lcom/motorola/groundloopnoisepreventer/SilenceService$4;
.super Landroid/content/BroadcastReceiver;
.source "SilenceService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/motorola/groundloopnoisepreventer/SilenceService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;


# direct methods
.method constructor <init>(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V
    .locals 0

    .prologue
    .line 159
    iput-object p1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x1

    .line 162
    const/4 v1, 0x0

    .line 163
    .local v1, "headsetState":I
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 165
    .local v0, "action":Ljava/lang/String;
    const-string v2, "android.intent.action.HEADSET_PLUG"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 166
    const-string v2, "state"

    const/4 v3, -0x1

    invoke-virtual {p2, v2, v3}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    .line 167
    packed-switch v1, :pswitch_data_0

    .line 175
    const-string v2, "SilencePlayer"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unexpected headset state:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # setter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z
    invoke-static {v2, v6}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$202(Lcom/motorola/groundloopnoisepreventer/SilenceService;Z)Z

    .line 180
    :cond_0
    :goto_0
    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z
    invoke-static {v2}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$200(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Z

    move-result v2

    if-ne v2, v5, :cond_3

    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mChargerState:Z
    invoke-static {v2}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$300(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Z

    move-result v2

    if-ne v2, v5, :cond_3

    .line 182
    const-string v2, "SilencePlayer"

    const-string v3, "Condition for Aux/Charger noise reduction"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 183
    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;
    invoke-static {v2}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$100(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/media/MediaPlayer;

    move-result-object v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;
    invoke-static {v2}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$100(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/media/MediaPlayer;

    move-result-object v2

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v2

    if-nez v2, :cond_2

    .line 184
    :cond_1
    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # invokes: Lcom/motorola/groundloopnoisepreventer/SilenceService;->prepareSilence()V
    invoke-static {v2}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$400(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V

    .line 189
    :cond_2
    :goto_1
    return-void

    .line 169
    :pswitch_0
    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # setter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z
    invoke-static {v2, v6}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$202(Lcom/motorola/groundloopnoisepreventer/SilenceService;Z)Z

    goto :goto_0

    .line 172
    :pswitch_1
    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # setter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z
    invoke-static {v2, v5}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$202(Lcom/motorola/groundloopnoisepreventer/SilenceService;Z)Z

    goto :goto_0

    .line 187
    :cond_3
    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # invokes: Lcom/motorola/groundloopnoisepreventer/SilenceService;->finishSilence()V
    invoke-static {v2}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$500(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V

    goto :goto_1

    .line 167
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
