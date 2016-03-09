.class Lcom/motorola/groundloopnoisepreventer/SilenceService$3;
.super Landroid/os/Handler;
.source "SilenceService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/motorola/groundloopnoisepreventer/SilenceService;->onCreate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;


# direct methods
.method constructor <init>(Lcom/motorola/groundloopnoisepreventer/SilenceService;Landroid/os/Looper;)V
    .locals 0
    .param p2, "x0"    # Landroid/os/Looper;

    .prologue
    .line 103
    iput-object p1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "inputMessage"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x1

    .line 106
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 121
    const-string v0, "SilencePlayer"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "unexpected case: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 125
    :cond_0
    :goto_0
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    .line 126
    return-void

    .line 108
    :pswitch_0
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;
    invoke-static {v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$100(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/media/MediaPlayer;

    move-result-object v0

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    goto :goto_0

    .line 111
    :pswitch_1
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;
    invoke-static {v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$100(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/media/MediaPlayer;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 112
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;
    invoke-static {v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$100(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/media/MediaPlayer;

    move-result-object v0

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    .line 113
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    const/4 v1, 0x0

    # setter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;
    invoke-static {v0, v1}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$102(Lcom/motorola/groundloopnoisepreventer/SilenceService;Landroid/media/MediaPlayer;)Landroid/media/MediaPlayer;

    .line 115
    :cond_1
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z
    invoke-static {v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$200(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Z

    move-result v0

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mChargerState:Z
    invoke-static {v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$300(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Z

    move-result v0

    if-ne v0, v2, :cond_0

    .line 117
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # invokes: Lcom/motorola/groundloopnoisepreventer/SilenceService;->prepareSilence()V
    invoke-static {v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$400(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V

    goto :goto_0

    .line 106
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
