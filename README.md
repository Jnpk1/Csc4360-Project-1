# MemoClub

## Useful Links

* [Link to Current Design Structure](https://www.figma.com/file/RugeWrPOBgDUWwE1prm6kZ/GroupProject1?node-id=1%3A143)
* [GitHub repo we can use for reference](https://github.com/ashtonjonesdev/reply_flutter)

## Image of Data Storage

`messageBoards      <---------- collection
-businessBoard     <------------- doc
--name: "BusinessBoard"  <------- field
--messages <--------------------- subcollection
---msg_uid  <-------------------- doc 
----content: "msg content"  <---- field
----date: Timestamp()
----author: "msg author"
---msg_uid2    <----------------- doc
----content: "msg2 content2" <-- field
----date: Timestamp2()
----author: "msg2 author2"
`

## BLoC Design Graphic

![img](https://cdn.discordapp.com/attachments/851552841395077214/858392404439597106/04-BLoC-diagram-1-650x284.png)

