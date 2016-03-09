.class public Lcom/motorola/groundloopnoisepreventer/SilenceService;
.super Landroid/app/Service;
.source "SilenceService.java"


# instance fields
.field private mChargerState:Z

.field private mFd:Landroid/content/res/AssetFileDescriptor;

.field private mHandler:Landroid/os/Handler;

.field private mHeadSetState:Z

.field private final mReceiver:Landroid/content/BroadcastReceiver;

.field private mRes:Landroid/content/res/Resources;

.field private mSilencePlayer:Landroid/media/MediaPlayer;

.field private mSilenceResId:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 26
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 159
    new-instance v0, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;

    invoke-direct {v0, p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService$4;-><init>(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V

    iput-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method static synthetic access$000(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/os/Handler;
    .locals 1
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHandler:Landroid/os/Handler;

    return-object v0
.end method

.method static synthetic access$100(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Landroid/media/MediaPlayer;
    .locals 1
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;

    .prologue
    .line 26
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    return-object v0
.end method

.method static synthetic access$102(Lcom/motorola/groundloopnoisepreventer/SilenceService;Landroid/media/MediaPlayer;)Landroid/media/MediaPlayer;
    .locals 0
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;
    .param p1, "x1"    # Landroid/media/MediaPlayer;

    .prologue
    .line 26
    iput-object p1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    return-object p1
.end method

.method static synthetic access$200(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;

    .prologue
    .line 26
    iget-boolean v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z

    return v0
.end method

.method static synthetic access$202(Lcom/motorola/groundloopnoisepreventer/SilenceService;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;
    .param p1, "x1"    # Z

    .prologue
    .line 26
    iput-boolean p1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z

    return p1
.end method

.method static synthetic access$300(Lcom/motorola/groundloopnoisepreventer/SilenceService;)Z
    .locals 1
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;

    .prologue
    .line 26
    iget-boolean v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mChargerState:Z

    return v0
.end method

.method static synthetic access$400(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V
    .locals 0
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;

    .prologue
    .line 26
    invoke-direct {p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->prepareSilence()V

    return-void
.end method

.method static synthetic access$500(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V
    .locals 0
    .param p0, "x0"    # Lcom/motorola/groundloopnoisepreventer/SilenceService;

    .prologue
    .line 26
    invoke-direct {p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->finishSilence()V

    return-void
.end method

.method private finishSilence()V
    .locals 2

    .prologue
    .line 81
    const-string v0, "SilencePlayer"

    const-string v1, "Condition cleared, stop noise reduction"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 82
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_1

    .line 83
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 84
    :cond_0
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    .line 85
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    .line 87
    :cond_1
    return-void
.end method

.method private prepareSilence()V
    .locals 7

    .prologue
    .line 52
    :try_start_0
    iget v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilenceResId:I

    invoke-static {p0, v0}, Landroid/media/MediaPlayer;->create(Landroid/content/Context;I)Landroid/media/MediaPlayer;

    move-result-object v0

    iput-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    .line 53
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->reset()V

    .line 54
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setLooping(Z)V

    .line 55
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    iget-object v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mFd:Landroid/content/res/AssetFileDescriptor;

    invoke-virtual {v1}, Landroid/content/res/AssetFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1

    iget-object v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mFd:Landroid/content/res/AssetFileDescriptor;

    invoke-virtual {v2}, Landroid/content/res/AssetFileDescriptor;->getStartOffset()J

    move-result-wide v2

    iget-object v4, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mFd:Landroid/content/res/AssetFileDescriptor;

    invoke-virtual {v4}, Landroid/content/res/AssetFileDescriptor;->getLength()J

    move-result-wide v4

    invoke-virtual/range {v0 .. v5}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;JJ)V

    .line 57
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    new-instance v1, Lcom/motorola/groundloopnoisepreventer/SilenceService$1;

    invoke-direct {v1, p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService$1;-><init>(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    .line 63
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    new-instance v1, Lcom/motorola/groundloopnoisepreventer/SilenceService$2;

    invoke-direct {v1, p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService$2;-><init>(Lcom/motorola/groundloopnoisepreventer/SilenceService;)V

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    .line 72
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepare()V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 78
    :goto_0
    return-void

    .line 73
    :catch_0
    move-exception v6

    .line 74
    .local v6, "e":Ljava/lang/IllegalStateException;
    invoke-virtual {v6}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_0

    .line 75
    .end local v6    # "e":Ljava/lang/IllegalStateException;
    :catch_1
    move-exception v6

    .line 76
    .local v6, "e":Ljava/io/IOException;
    invoke-virtual {v6}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "arg0"    # Landroid/content/Intent;

    .prologue
    .line 156
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 91
    iput-boolean v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHeadSetState:Z

    .line 92
    iput-boolean v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mChargerState:Z

    .line 93
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilencePlayer:Landroid/media/MediaPlayer;

    .line 94
    const/high16 v1, 0x7f040000

    iput v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilenceResId:I

    .line 95
    invoke-virtual {p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iput-object v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mRes:Landroid/content/res/Resources;

    .line 96
    iget-object v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mRes:Landroid/content/res/Resources;

    iget v2, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mSilenceResId:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->openRawResourceFd(I)Landroid/content/res/AssetFileDescriptor;

    move-result-object v1

    iput-object v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mFd:Landroid/content/res/AssetFileDescriptor;

    .line 99
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 100
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v1, "android.intent.action.HEADSET_PLUG"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 101
    iget-object v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 103
    new-instance v1, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, p0, v2}, Lcom/motorola/groundloopnoisepreventer/SilenceService$3;-><init>(Lcom/motorola/groundloopnoisepreventer/SilenceService;Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mHandler:Landroid/os/Handler;

    .line 128
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 150
    iget-object v0, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 151
    invoke-direct {p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->finishSilence()V

    .line 152
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 4
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    .line 132
    invoke-virtual {p1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 134
    .local v0, "action":Ljava/lang/String;
    const-string v1, "com.motorola.groundloopnoisepreventer.action.CHARGER_DISCONNECTED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 135
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mChargerState:Z

    .line 136
    invoke-direct {p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->finishSilence()V

    .line 137
    invoke-virtual {p0}, Lcom/motorola/groundloopnoisepreventer/SilenceService;->stopSelf()V

    .line 145
    :goto_0
    const/4 v1, 0x3

    return v1

    .line 138
    :cond_0
    const-string v1, "com.motorola.groundloopnoisepreventer.action.CHARGER_CONNECTED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 139
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/motorola/groundloopnoisepreventer/SilenceService;->mChargerState:Z

    goto :goto_0

    .line 141
    :cond_1
    const-string v1, "SilencePlayer"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "unsupported action:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
