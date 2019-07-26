**ios 打包步骤**

1. 编译
2. 链接
3. 合并可执行文件
4. 针对SDWebImage.FrameWork 等第三方库进行签名
5. 创建 工程名字.app 文件夹
6. 将profile文件，plist 文件，可执行文件，frameWork ,image 等必须资源，copy 工程名字.app 文件夹中
7. 对于”工程名字.app“ 文件夹签名
8. 创建 Payload 文件夹，将工程名字.app 移动到Payload文件夹中
9. 压缩Payload文件夹，并且重命名为 .ipa 文件
