.class Lcom/motorola/groundloopnoisepreventer/SilenceService$2;
.super Ljava/lang/Object;
.source "SilenceService.java"

# interfaces
.implements Landroid/media/MediaPlayer$OnErrorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/motorola/groundloopnoisepreventer/SilenceService;->prepareSilence()V
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
    .line 63
    iput-object p1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$2;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 3
    .param p1, "mp"    # Landroid/media/MediaPlayer;
    .param p2, "what"    # I
    .param p3, "extra"    # I

    .prologue
    .line 66
    const-string v0, "SilencePlayer"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SilencePlayer error : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService$2;->this$0:Lcom/motorola/groundloopnoisepreventer/SilenceService;

    # getter for: Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHandler:Landroid/os/Handler;
    invoke-static {v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->access$000(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/os/Handler;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendEmptyMessage(I)Z

    .line 68
    const/4 v0, 0x1

    return v0
.end method
