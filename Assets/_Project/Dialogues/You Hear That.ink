VAR trust = 20
VAR tp = 0
VAR knows_about_mary = false
VAR knows_about_buster = false
VAR knows_camp2_secret = false
VAR talk_count_act1 = 0
VAR is_viewing_camper = false
VAR is_viewing_camp2 = false
VAR is_viewing_cam1 = false
VAR is_viewing_cam4 = false
VAR is_viewing_cam7 = false
VAR is_viewing_monster = false
VAR has_visited_camp1 = false
VAR has_battery = false
VAR find_key = false
VAR put_key = false
VAR has_key = false
VAR know_about_key = false
VAR calm1 = false
VAR calm2 = false
VAR knows_about_story = false
VAR knows_about_wings = false

=== start_game ===
-> act1_incident

=== test_game ===
hi
-> DONE

=== act1_incident ===
NGƯỜI CẮM TRẠI: "--Này! Có ai ở trạm không? Làm ơn... trả lời tôi đi! Có ai nghe thấy tôi không?!" #SFX:Radio_Turning
+ [Tôi nghe đây. Anh bình tĩnh, hít thở sâu rồi nói tôi nghe có chuyện gì nào.]
    ~ trust += 10
    NGƯỜI CẮM TRẠI: "Ơn giời! Anh kiểm lâm, tôi đang ở gần chỗ cái hồ nhỏ. Tôi vừa xuống mép nước rửa mặt một tí, quay lên cái balo bốc hơi mất tiêu rồi! Cả lều, cả đồ ăn của tôi nữa!"
    -> small_lake_loop
+ [Tôi nghe rồi. Anh đứng yên đó, đừng đi lung tung. Mô tả chỗ đó cho tôi.]
    ~ tp += 5
    NGƯỜI CẮM TRẠI: "Tôi đang ở cạnh một cái hồ nhỏ, xung quanh toàn mấy cây thông cao vút. Anh kiểm lâm ơi, tôi bị mất sạch đồ đạc rồi! Quay đi có một loáng mà cái balo nó biến mất như chưa từng tồn tại ấy!" 
    -> small_lake_loop

=== small_lake_loop ===
{talk_count_act1 >= 2 && is_viewing_camper: -> act1_battery_event_start}

+ [Trong cái balo đó có cái gì quan trọng lắm không?]
    ~ talk_count_act1 += 1
    ~ knows_about_mary = true
    NGƯỜI CẮM TRẠI: "Có điện thoại, ví tiền... với cái ảnh cưới của tôi. Vợ tôi tên là Mary, cô ấy mà biết tôi làm mất cái ảnh chắc lo phát điên mất."
    -> small_lake_loop
+ [Sao anh lại đi dã ngoại một mình vào cái giờ này?]
    ~ talk_count_act1 += 1
    NGƯỜI CẮM TRẠI: "Tôi làm thiết kế đồ họa, anh kiểm lâm ạ. Cả tuần nhìn cái màn hình với deadline, tôi chỉ muốn tìm chỗ nào không có sóng điện thoại để thở một chút thôi."
    -> small_lake_loop
+ {talk_count_act1 >= 2} [Tôi đang tìm anh trên camera, anh đứng yên đó nhé.]
    NGƯỜI CẮM TRẠI: "Vâng, tôi đang đứng yên đây. Anh có thấy cái thứ gì quanh đây không?"
    -> small_lake_loop

=== act1_battery_event_start ===
NGƯỜI CẮM TRẠI: "Ế bị sao vậy!?" #EVENT:StartFlicker

+ [Đợi đã... hình như cái đèn pin của anh vừa bị nháy đúng không?]
    NGƯỜI CẮM TRẠI: "Chết tiệt! Đúng rồi anh ơi! Nó hết pin rồi! Nếu nó tắt ngóm ở đây thì tôi xong đời mất! Anh cứu tôi với!"
    -> battery_help

=== battery_help ===
+ [Gần đây có một vài khu cắm trại cũ. Ở đó chắc sẽ có pin hoặc đèn pin khác. Để tôi dẫn anh tới đó lấy đồ nhé?]
    ~ trust += 10
    NGƯỜI CẮM TRẠI: "Khu cắm trại cũ hả anh? Nghe thì hơi sợ nhưng tôi không muốn mò mẫm trong bóng tối đâu. Anh chỉ đường đi!"
    -> intro_SmallLake


=== intro_SmallLake ===
NGƯỜI CẮM TRẠI: "Chỗ này lạnh thật đấy!"
-> node_SmallLake

=== node_SmallLake ===
+ [Di chuyển] -> move_SmallLake
+ [Trò chuyện] -> talk_SmallLake

=== move_SmallLake ===
+ [Đi qua cây cầu phía trước, chỗ có mấy tảng đá khổng lồ.]
    NGƯỜI CẮM TRẠI: "Được rồi, tôi đi đây" #MOVE:Waypoint_Rocky 
    -> intro_Rocky
+ [Đi theo cây cầu phía bên phải của anh, chỗ có biển câu cá ấy.]
    NGƯỜI CẮM TRẠI: "Được rồi, tôi đi đây" #MOVE:Waypoint_Fishing
    -> intro_Fishing
+ [Trở về] -> node_SmallLake

=== talk_SmallLake ===
* [Anh thấy khu rừng về đêm như thế nào, có đẹp không.]
    ~ trust -=10
    NGƯỜI CẮM TRẠI: "Đó đâu phải là thứ anh nên hỏi vào lúc này." -> talk_SmallLake
* [Anh có mang theo nước uống bên mình không?]
    ~ trust += 5
    NGƯỜI CẮM TRẠI: "Tôi vừa uống ở hồ lúc nãy rồi. Ít nhất thì cũng không chết khát được." -> talk_SmallLake
+ [Trở về] -> node_SmallLake


=== intro_Rocky ===
NGƯỜI CẮM TRẠI: "Mấy tảng đá ở đây nhìn to thật đấy."
-> node_Rocky

=== node_Rocky ===
+ [Di chuyển] -> move_Rocky
+ [Trò chuyện] -> talk_Rocky

=== move_Rocky ===
+ [Tiếp tục đi về phía những đồi đá, anh sẽ nghe thấy tiếng thác nước.]
    NGƯỜI CẮM TRẠI: "Tiến về phía trước, hiểu rồi." #MOVE:Waypoint_Waterfall 
    -> intro_Waterfall
+ [Đi quay lại phía cây cầu về khu hồ nhỏ đó.]
    NGƯỜI CẮM TRẠI: "Được để tôi quay lại." #MOVE:Waypoint_SmallLake 
    -> intro_SmallLake
+ [Trở về] -> node_Rocky

=== talk_Rocky ===
* [Anh có nuôi động vật hay thú cưng gì không?]
    ~ knows_about_buster = true
    ~ trust += 10
    NGƯỜI CẮM TRẠI: "Tôi có nuôi một chú Golden Retriever béo ú. Nó hay tăng động và nhiều năng lượng lắm. Nghĩ đến nó làm tôi thấy an tâm hơn." -> talk_Rocky
* [Anh có thấy bị vấn đề gì về sức khoẻ không?]
    ~tp += 10
    NGƯỜI CẮM TRẠI: "Tôi ổn, có lẽ ngoại trừ việc đang sợ chết khiếp ra đây." -> talk_Rocky
+ [Trở về] -> node_Rocky


=== intro_Waterfall ===
NGƯỜI CẮM TRẠI: "Thác nước chảy mạnh quá, tiếng ầm ầm kinh thật." -> node_Waterfall

=== node_Waterfall ===
+ [Di chuyển] -> move_Waterfall
+ [Trò chuyện] -> talk_Waterfall

=== move_Waterfall ===
+ [Trước mặt anh có cái cây khổng lồ, hãy đi men theo con đường cạnh nó.]
    NGƯỜI CẮM TRẠI: "Hướng về cái cây khổng lồ nào!" #MOVE:Waypoint_BigTree
    -> intro_BigTree
+ [Đi lại về phía mấy tảng đá to.]
    NGƯỜI CẮM TRẠI: "Được, để tôi đi đến đó."#MOVE:Waypoint_Rocky
    -> intro_Rocky
+ [Trở về] -> node_Waterfall

=== talk_Waterfall ===
* [Anh có nghe thấy tiếng ai gọi không?]
    ~ tp += 10
    NGƯỜI CẮM TRẠI: "Anh đừng hù tôi chứ! Tôi chỉ nghe thấy tiếng nước thôi!" -> talk_Waterfall
* {knows_about_mary} [Vợ của anh là người như thế nào?]
    ~ trust += 5
    NGƯỜI CẮM TRẠI: "Cô ấy là người tuyệt vời nhất trên thế gian này đấy! Nếu chúng ta vượt qua chuyện này tôi sẽ giới thiệu cô ấy với anh." -> talk_Waterfall
+ [Trở về] -> node_Waterfall

=== intro_BigTree ===
NGƯỜI CẮM TRẠI: "Nhìn gần mới thấy cái cây này to kinh khủng luôn ấy"
-> node_BigTree

=== node_BigTree ===
{
    - knows_camp2_secret:
        NGƯỜI CẮM TRẠI: "Vậy là có con đường bí mật sau chỗ cỏ cao này sao..."
        + [Hãy thở đều trước đã, sau đó chúng ta sẽ tiến vào trong.]
            NGƯỜI CẮM TRẠI: "Được rồi đi thôi!" #MOVE:Waypoint_OldBuilding.  
            -> intro_OldBuilding
}

+ [Di chuyển] -> move_BigTree
+ [Trò chuyện] -> talk_BigTree

=== move_BigTree ===
+ [Đi sâu vào lối mòn phía sau cây, dừng ở ngã ba.]
    NGƯỜI CẮM TRẠI: "Hiểu rồi, tôi đi liền." #MOVE:Waypoint_BigTree2 
    -> intro_BigTree2
+ [Quay lại về phía thác nước kia.]
    NGƯỜI CẮM TRẠI: "Hiểu rồi, tôi đi liền." #MOVE:Waypoint_Waterfall
    -> intro_Waterfall
+ [Trở về] -> node_BigTree

=== talk_BigTree ===
* [Nghề thiết kế chắc áp lực lắm nhỉ?]
    ~ trust += 5
    ~ tp += 10
    NGƯỜI CẮM TRẠI: "Anh thử tưởng tượng làm đến đâu khách đòi sửa đến đấy." 
    NGƯỜI CẮM TRẠI: "Xong không làm đúng ý khách hàng thì còn bị sếp mắng nữa, mắc mệt luôn." -> talk_BigTree
+ [Trở về] -> node_BigTree

=== intro_BigTree2 ===
NGƯỜI CẮM TRẠI: "Sương mù dày quá, tôi chả nhìn thấy gì ở phía xa cả."
-> node_BigTree2

=== node_BigTree2 ===
+ [Di chuyển] -> move_BigTree2
+ [Trò chuyện] -> talk_BigTree2

=== move_BigTree2 ===
+ [Đi về cây cầu phía bên trái.]
    NGƯỜI CẮM TRẠI: "Cây cầu bên trái, hiểu rồi." #MOVE:Waypoint_BridgeNearCamp2 
    -> intro_BridgeNearCamp2
+ [Tiến về phía cây cầu bên phải.]
    NGƯỜI CẮM TRẠI: "Cây cầu bên phải, hiểu rồi." #MOVE:Waypoint_StoneLake1
    -> intro_StoneLake1
+ [Trở về hướng cái cây đi.]
    NGƯỜI CẮM TRẠI: "Hướng cái cây khổng lồ hả, được." #MOVE:Waypoint_BigTree 
    -> intro_BigTree
+ [Trở về] -> node_BigTree2

=== talk_BigTree2 ===
* [Cố lên, chúng ta sắp tới nơi rồi.]
    ~ trust += 10
    ~ tp += 10
    NGƯỜI CẮM TRẠI: "Thật sao, anh không lừa tôi đấy chứ." -> talk_BigTree2
* [Nhanh lên, chúng ta không còn nhiều thời gian đâu.]
    ~ trust -= 20
    ~ tp += 20
    NGƯỜI CẮM TRẠI: "Tôi cũng mệt lắm chứ, anh đâu phải là người ở ngoài này đâu." -> talk_BigTree2
+ [Trở về] -> node_BigTree2

=== intro_BridgeNearCamp2 ===
NGƯỜI CẮM TRẠI: "Tôi đang đứng ngay trước cây cầu rồi, giờ sao?"
-> node_BridgeNearCamp2

=== node_BridgeNearCamp2 ===
+ [Di chuyển] -> move_BridgeNearCamp2
+ [Trò chuyện] -> talk_BridgeNearCamp2

=== move_BridgeNearCamp2 ===
+ [Đi qua cầu là anh sẽ thấy khu cắm trại đó.] 
    NGƯỜI CẮM TRẠI: "Được, để tôi đi"#MOVE:Waypoint_Camp2
    -> intro_Camp2
+ [Anh hãy quay về hướng ngã ba đi.] 
    NGƯỜI CẮM TRẠI: "Được, để tôi đi"#MOVE:Waypoint_BigTree2 
    -> intro_BigTree2
+ [Trở về] -> node_BridgeNearCamp2

=== talk_BridgeNearCamp2 ===
+ [Trở về] -> node_BridgeNearCamp2

=== intro_Fishing===
NGƯỜI CẮM TRẠI: "Chỗ này là chỗ người ta hay câu cá hả? Ồ có cá thật này."
->node_Fishing

=== node_Fishing ===
+ [Di chuyển] -> move_Fishing
+ [Trò chuyện] -> talk_Fishing

=== move_Fishing ===
+ [Anh có thấy quanh đó có cái hồ lớn nào không?]
    NGƯỜI CẮM TRẠI: "Hồ lớn... hồ lớn, à thấy rồi, để tôi đi về phía đó." #MOVE:Waypoint_BigLake 
    -> intro_BigLake
+ [Quay lại về chỗ hồ nhỏ đi.]
    NGƯỜI CẮM TRẠI: "Được, để tôi đi." #MOVE:Waypoint_SmallLake 
    -> intro_SmallLake
+ [Trở về] -> node_Fishing

=== talk_Fishing ===
* [Anh có nuôi động vật hay thú cưng gì không?]
    ~ knows_about_buster = true
    ~ trust += 10
    NGƯỜI CẮM TRẠI: "Tôi có nuôi một chú Golden Retriever béo ú. Nó hay tăng động và nhiều năng lượng lắm. Nghĩ đến nó làm tôi thấy an tâm hơn." -> talk_Fishing
* [Anh có thấy bị vấn đề gì về sức khoẻ không?]
    ~tp += 10
    NGƯỜI CẮM TRẠI: "Tôi ổn, có lẽ ngoại trừ việc đang sợ chết khiếp ra đây." -> talk_Fishing
+ [Trở về] -> node_Fishing

=== intro_BigLake ===
NGƯỜI CẮM TRẠI: "Hồ này rộng thật, sương mù dày quá tôi chẳng thấy gì ngoài mép nước."
->node_BigLake

=== node_BigLake ===
+ [Di chuyển] -> move_BigLake
+ [Trò chuyện] -> talk_BigLake

=== move_BigLake ===
+ [Tiếp tục đi theo lối mòn theo hướng của khu cắm trại gần chỗ anh.]
    NGƯỜI CẮM TRẠI: "À đây là chỗ ban đầu tôi định đặt lều nè." #MOVE:Waypoint_NearCamp1 
    -> intro_NearCamp1
+ [Anh hãy quay lại về khu câu cá nhé.]
    NGƯỜI CẮM TRẠI: "Được, để tôi đi." #MOVE:Waypoint_Fishing 
    -> intro_Fishing
+ [Anh thử tiến về phía cổng chính xem.]
    NGƯỜI CẮM TRẠI: "Được." #MOVE:Waypoint_MainGate 
    -> intro_MainGate
+ [Trở về] -> node_BigLake

=== talk_BigLake ===
* [Anh có sở thích gì không?]
    ~ trust += 5
    ~ tp += 5
    NGƯỜI CẮM TRẠI: "Tôi cũng từng có ước mơ làm vận động viên bơi lội đấy! Mà nó là quá khứ rồi."
    NGƯỜI CẮM TRẠI: "Nếu không phải bị tình huống này thì chắc tôi cũng đã thử bơi ở đây rồi." -> talk_BigLake
* [Nghề thiết kế chắc áp lực lắm nhỉ?]
    ~ trust += 5
    ~ tp += 10
    NGƯỜI CẮM TRẠI: "Anh thử tưởng tượng làm đến đâu khách đòi sửa đến đấy." 
    NGƯỜI CẮM TRẠI: "Xong không làm đúng ý khách hàng thì còn bị sếp mắng nữa, mắc mệt luôn." -> talk_BigLake
+ [Trở về] -> node_BigLake


=== intro_NearCamp1 ===
NGƯỜI CẮM TRẠI: "Được rồi, giờ tôi phải làm gì tiếp?"
-> node_NearCamp1

=== node_NearCamp1 ===
+ {not has_visited_camp1} [Anh thử vào bên trong xem còn đồ gì bỏ lại không.]
    ~ has_visited_camp1 = true
    NGƯỜI CẮM TRẠI: "Được, để tôi vào xem thử xem sao." 
    #MOVE:Waypoint_Camp1
    -> intro_Camp1
+ [Di chuyển] -> move_NearCamp1
+ [Trò chuyện] -> talk_NearCamp1

=== move_NearCamp1 ===
+ [Đi thẳng về lối mòn dọc con sông.]
    NGƯỜI CẮM TRẠI: "Là phía này hả, để tôi đi" #MOVE:Waypoint_StoneLake1 
    -> intro_StoneLake1
+ [Đi về hướng cái hồ to vừa nãy.]
    NGƯỜI CẮM TRẠI: "Được, để tôi đi." #MOVE:Waypoint_BigLake 
    -> intro_BigLake
+ [Phía tây sẽ có cây cầu bắc qua sông, nó sẽ dẫn anh tới chỗ trạm của tôi"]
    NGƯỜI CẮM TRẠI: "Chỗ của anh sao, tuyệt vời." #MOVE:Waypoint_WatchTower
    ~ trust += 5 
    -> intro_WatchTower
+ [Trở về] -> node_NearCamp1

=== talk_NearCamp1 ===
* [Dạo này cũng ít hẳn khách đi cắm trại ở đây hơn."]
    ~ tp += 10
    NGƯỜI CẮM TRẠI: "Vậy sao, chắc hẳn là do vụ mất tích kia hả... Giờ tôi sợ rồi đấy!" -> talk_NearCamp1
* {knows_about_buster} [Anh kể thêm một chút về Buster được không?"]
    ~ trust += 5
    ~ tp -= 10
    NGƯỜI CẮM TRẠI: "Nó cũng là một ông già 8 tuổi rồi đấy! Nhưng mà vẫn nhanh nhẹn với năng động lắm." 
    NGƯỜI CẮM TRẠI: "Mỗi sáng nó đều đánh thức tôi dậy với cái đuôi vẫy vẫy, trông đáng yêu thật sự."-> talk_NearCamp1
+ [Trở về] -> node_NearCamp1

=== intro_Camp1 ===
NGƯỜI CẮM TRẠI: "Trong này cũng chẳng còn gì nữa rồi, trống không luôn. Thất vọng thật."
~ tp += 5
-> node_Camp1

=== node_Camp1 ===
+ {is_viewing_camp2} [Vẫn còn một khu cắm trại cũ nữa, để tôi dẫn anh tới đó.]
    ~ trust += 10
    NGƯỜI CẮM TRẠI: "Khu trại khác sao? May quá! Anh chỉ đường giúp tôi với." #MOVE:Waypoint_NearCamp1
    -> node_NearCamp1
+ [Đợi tôi một chút, để tôi xem còn khu nào khác không...]
    NGƯỜI CẮM TRẠI: "Vâng, anh tìm nhanh lên nhé... đèn của tôi sắp hỏng tới nơi rồi."
    -> node_Camp1

=== intro_StoneLake1 ===
NGƯỜI CẮM TRẠI: "Ui cha chỗ này cũng lạnh người ghê ấy." #EVENT:StartFlicker
NGƯỜI CẮM TRẠI: "Đèn lại nhấp nháy tiếp rồi..."
~ tp += 15
-> node_StoneLake1

=== node_StoneLake1 ===
+ [Di chuyển] -> move_StoneLake1
+ [Trò chuyện] -> talk_StoneLake1

=== move_StoneLake1 ===
+ [Phía Tây sẽ có một cái con sông, anh hãy đi qua cây cầu chỗ đó là tới khu cắm trại.]
    NGƯỜI CẮM TRẠI: "Phía Tây là... à hướng này. Con sông này có nhiều tảng đá lồi lên vậy." #MOVE:Waypoint_Camp2 
    -> intro_Camp2
+ [Đi theo con đường mòn, anh sẽ tìm được khu cắm trại số 1.]
    NGƯỜI CẮM TRẠI: "Hiểu rồi, nhưng tới đó làm gì vậy?" #MOVE:Waypoint_NearCamp1
    ~ trust -= 10
    ~ tp += 5
    -> intro_NearCamp1
+ [Trở về] -> node_StoneLake1

=== talk_StoneLake1 ===
* [Cố lên, chúng ta sắp tới nơi rồi.]
    ~ trust += 10
    ~ tp += 10
    NGƯỜI CẮM TRẠI: "Thật sao, ơn trời." -> talk_BigTree2
* [Nhanh lên, chúng ta không còn nhiều thời gian đâu.]
    ~ trust -= 20
    ~ tp += 20
    NGƯỜI CẮM TRẠI: "Tôi cũng mệt lắm chứ, anh đâu phải là người ở ngoài này đâu." -> talk_BigTree2
+ [Trở về] -> node_StoneLake1

=== intro_MainGate ===
NGƯỜI CẮM TRẠI: "Cổng chính ở đây, nhưng nó bị khoá mất rồi. Anh có chìa khoá không?"
-> node_MainGate

=== intro_MainGate_Key ===
NGƯỜI CẮM TRẠI: "Đến lúc thoát ra khỏi đây rồi."
-> node_MainGate

=== node_MainGate ===
+ [Di chuyển] -> move_MainGate
+ [Trò chuyện] -> talk_MainGate

=== move_MainGate ===
+ [Quay lại đi.]
    {not has_key: 
        NGƯỜI CẮM TRẠI: "Cũng chẳng còn đường nào để đi nữa mà." #MOVE:Waypoint_BigLake
        -> intro_BigLake
    }
    {has_key: 
        NGƯỜI CẮM TRẠI: "Anh bị điên hả? Sao lại bắt tôi quay lại cơ chứ?"
        ~ trust -= 15
        ~ tp += 15
        -> talk_MainGate
    }
+ [Trở về] -> node_MainGate

=== talk_MainGate ===
* {has_key} [Dùng chìa khoá mở cánh cổng ra đi]
    NGƯỜI CẮM TRẠI: "Tôi đang cố gắng đây!"
    {trust > 50 && tp < 50: -> good_ending_normal | -> bad_ending_caught}
* {find_key && not has_key} [Tôi tìm thấy chiếc chìa khoá cổng rồi, tôi sẽ để nó ở ngay trên cửa vào tháp của tôi nhé.]
    ~ know_about_key = true
    NGƯỜI CẮM TRẠI: "Tốt quá! Anh hãy chỉ đường giúp tôi đến chỗ anh với!"
    -> talk_MainGate
* [Không biết là liệu tôi có chìa khoá cổng không nữa...]
    NGƯỜI CẮM TRẠI: "Làm ơn hãy nói là anh có."
    -> talk_MainGate
+ [Trở về] -> node_MainGate

=== intro_WatchTower ===
NGƯỜI CẮM TRẠI: "Tôi thấy trạm của anh rồi! Tôi đang đứng ở cổng đây!"
-> node_WatchTower

=== node_WatchTower ===
+ [Di chuyển] -> move_WatchTower
+ [Trò chuyện] -> talk_WatchTower

=== move_WatchTower ===
+ [Đi hướng trước mặt, con đường dẫn tới khu trại đấy.] #MOVE:Waypoint_Camp2 
    -> intro_Camp2
+ [Quay về chỗ ngã ba gần khu cắm trại kia.] #MOVE:Waypoint_NearCamp1 
    -> intro_NearCamp1
+ [Trở về] 
    -> node_WatchTower

=== talk_WatchTower ===
* {find_key && know_about_key} [Anh thấy chìa khoá chưa?]
    {
        - put_key:
            ~ has_key = true
	    ~ find_key = false
            NGƯỜI CẮM TRẠI: "Tôi thấy chìa khoá rồi, cảm tạ anh. Để tôi đi ra cổng chính ngay lập tức." #MOVE:Waypoint_MainGate
            -> intro_MainGate_Key
        - else:
            ~ trust -= 15
            ~ tp += 15
            NGƯỜI CẮM TRẠI: "Tôi đâu thấy chiếc chìa khoá nào đâu? Anh đùa tôi đúng không!"
            -> talk_WatchTower
    }
* [Cố lên, chúng ta sắp đến khu trại rồi.]
    NGƯỜI CẮM TRẠI: "Được, một chút nữa thôi!"
    -> talk_WatchTower
+ [Trở về] 
    -> node_WatchTower

=== intro_Camp2 ===
NGƯỜI CẮM TRẠI: "Có vẻ đây là nơi chúng ta cần tới!"
NGƯỜI CẮM TRẠI: "Tôi tới khu trại cũ rồi! Để tôi tìm bên trong lều xem."
NGƯỜI CẮM TRẠI: "Có pin rồi! Đèn sáng lại rồi anh ơi!" #EVENT:WarningFlicker
~ has_battery = true
-> node_Camp2

=== node_Camp2 ===
+ [Di chuyển] -> move_Camp2
+ [Trò chuyện] -> talk_Camp2

=== move_Camp2 ===
+ [Anh đi về hướng cây cầu gần đó nhé.]
    NGƯỜI CẮM TRẠI: "Tại sao chúng ta lại đi về đó vậy" #MOVE:Waypoint_Camp2 
    -> intro_Camp2
    ~ trust -= 5
    ~ tp += 5
+ [Hãy đi về hướng toà tháp cao, tôi sẽ tìm cách giúp anh.]
    NGƯỜI CẮM TRẠI: "Được tôi thấy rồi, đợi tôi một chút" #MOVE:Waypoint_WatchTower
    -> intro_WatchTower
    ~ trust += 5
    ~ tp -= 10
+ [Trở về] -> node_MainGate

=== talk_Camp2 ===
* [Anh tìm xem còn gì hữu ích không.]
    NGƯỜI CẮM TRẠI: "Ở đây có vẻ còn nhiều đồ lắm, để tôi xem..."
    -> find_diary

=== find_diary ===
NGƯỜI CẮM TRẠI: "Tôi tìm thấy một cuốn nhật ký..."
NGƯỜI CẮM TRẠI: "Chúng tôi đã tìm thấy một căn chòi bí ẩn. Nó trông rất hoang sơ và đổ nát, nằm ẩn mình sau những tán cây rậm rạp và vách núi cao."
NGƯỜI CẮM TRẠI: "Từ hướng cái cây khổng lổ đi vào bên trong bãi đất trống, sẽ thấy có một chiếc cầu bắc qua sông đằng sau những cỏ cây rậm rạp."
NGƯỜI CẮM TRẠI: "Chúng tôi thấy có một miếng dán hình vẽ kì lạ dán ở mép cửa, chúng tôi đã bóc nó để xem bên trong căn chòi ấy có gì."
NGƯỜI CẮM TRẠI: "Toàn những thứ kì quặc như mấy cái dấu ấn ngôi sao hay là mấy cái đầu động vật, ở giữa phòng có một cái vòng tròn với mấy kí tự kì quặc và ở trong vòng tròn đó có một quyển sách kì lạ."
NGƯỜI CẮM TRAI: "Một người bạn của tôi quyết định nhặt cuốn sách lên để đọc xem bên trong có gì, nhưng toàn ngôn ngữ trông lạ hoắc nên chả ai trong chúng tôi đọc được."
NGƯỜI CẮM TRẠI: "Ban đầu chúng tôi nghĩ trong này là đồ trang trí halloween hay gì đấy, nhưng sớm thôi chúng tôi sẽ thấy hối hận vì đã làm chuyện này."
NGƯỜI CẮM TRẠI: "Sau khi tìm kiếm xung quanh ngôi nhà cũng chẳng còn gì thú vị nữa, nên chúng tôi quyết định ra về."
NGƯỜI CẮM TRẠI: "Tuy nhiên sau chuyện này mỗi người trong chúng tôi dần dần biến mất. Có người thì đi vệ sinh xong biến mất, có người thì vì đi tìm người mất tích xong cũng chẳng còn thấy đâu nữa. Một người trong chúng tôi còn bị hoá điên đến mức mất kiểm soát."
NGƯỜI CẮM TRẠI: "Tôi là người cuối cùng trong nhóm này, đã 6 tiếng kể từ lúc chúng tôi khám phá ra căn chòi kia, lẽ ra bọn tôi không nên tọc mạch ở đó. Tôi đã báo cáo với người kiểm lâm tại khu vực này, anh ấy bảo tôi trở lại căn chòi để nói chuyện, giờ tôi sẽ phó mặc vào số phận vậy."
NGƯỜI CẮM TRẠI: "Đoạn nhật kí dừng ở đây..."
~ knows_camp2_secret = true
+ [Hoá ra đây là nguyên nhân những người ở đây biến mất.] -> doubt_trust

=== doubt_trust ===
NGƯỜI CẮM TRẠI: "Đoạn nhật ký nhắc đến anh, có phải anh là người lừa họ không!?"
+ [Anh bình tĩnh, tôi đâu có biết chuyện gì đã xảy ra đâu.]
    {
        - trust < 30:
            NGƯỜI CẮM TRẠI: "Hoá ra đó giờ tôi đều bị dắt mũi sao? Tôi không thể tin tưởng anh được nữa. Chết tiệt tôi phải thoát ra khỏi đây!"
            -> bad_ending_rogue
        - trust > 75:
            NGƯỜI CẮM TRẠI: "Hừm, cũng đúng, có lẽ tôi chỉ hơi mất bình tĩnh một chút thôi. Giờ sao, quay lại chỗ cái cây hả?"
            -> trust75_choices
        - else:
            NGƯỜI CẮM TRẠI: "Có lẽ tôi sẽ phải cẩn thận hơn vậy."
            ~ trust -= 15
            ~ tp += 10
            -> move_Camp2
    }

=== trust75_choices ===
+ [Anh có muốn quay lại không?]
    NGƯỜI CẮM TRẠI: "Tôi cũng muốn biết thêm về thứ đã ám quẻ tôi suốt cả buổi này. Đi thôi." #MOVE:Waypoint_BigTree
    -> node_BigTree
+ [Tôi nghĩ chúng ta nên lựa chọn an toàn, tôi sẽ tìm chìa khoá cổng và đưa cho anh ở cửa khu tháp canh nhé.] 
    NGƯỜI CẮM TRẠI: "Vậy sao, được rồi tôi sẽ nghe anh!" #MOVE:Waypoint_WatchTower 
    -> node_WatchTower

=== intro_OldBuilding ===
NGƯỜI CẮM TRẠi: "Quả thực là có một căn chòi ở sau núi này! Sao tự nhiên tôi thấy sợ sợ quá vậy."
+ [Cố lên, chúng ta sắp tìm ra sự thật rồi!]
    NGƯỜI CẮM TRẠI: "Anh nói đúng, chúng ta đã đến nước này rồi thì không thể quay lại được nữa!" #MOVE:Waypoint_OldBuilding
    -> node_OldBuilding

=== node_OldBuilding ===
NGƯỜI CẮM TRẠI: "Quả nhiên là có chiếc băng dán hình ngôi sao bị ném ở trước cửa. Giờ tôi sẽ tiến vào bên trong đây."
NGƯỜI CẮM TRẠI: "(Tiếng kẽo kẹt của cánh cửa cũ)" #SFX:Open_Old_Door
NGƯỜI CẮM TRẠI: "Bên trong... quái quỷ thật đấy. Một đống thứ trông như bùa ngải đặt khắp nơi, có nhiều hình vẽ kì lạ, đầu động vật cũng được treo khắp tường nữa."
NGƯỜI CẮM TRẠI: "Thực sự là giữa phòng có một vòng tròn kì quái, nhưng không có cuốn sách ở trong vòng tròn đó như trong nhật ký họ đã bảo."
+ [Xung quanh căn nhà đó còn gì đáng chú ý nữa không?]
    NGƯỜI CẮM TRẠI: "Có vài cái kệ sách và một chồng sách chất đống trên bàn nhưng... Cái nào là quyển mà chúng ta cần tìm vậy?" -> calm_talk

=== calm_talk ===
NGƯỜI CẮM TRẠI: "Để tôi xem, đúng là có một cuốn có hình con dê, sao anh biết hay vậy?"
+ [Hả, anh đang nói gì vậy?]
    NGƯỜI CẮM TRẠI: "Hả chẳng phải anh bảo là quyển sách có hình con dê ở mặt bìa sao?"
    ++ [Tôi đâu có nói vậy. Anh có nghe nhầm không?]
        NGƯỜI CẮM TRẠI: "Hả vậy ai vừa-- Chẳng lẽ nào... Ahhhhhhhh!!!!"
        +++ [Bình tĩnh lại, tôi cần anh phải bình tĩnh lại! Nghe tôi nói này!]
            NGƯỜI CẮM TRẠI: "ANH LÀ AI, AI MỚI LÀ NGƯỜI THẬT VẬY, TRỜI ƠI, CHẾT TIỆT, TÔI PHẢI THOÁT RA KHỎI ĐÂY!" -> check_mary

=== check_mary ===
{
    - knows_about_mary: 
        + [Hãy nhớ về người vợ Mary của anh, cô ấy đang đợi anh ở nhà đấy có nhớ không?]
        ~ calm1 = true
        NGƯỜI CẮM TRẠI: "Vợ của tôi... Phải, phải đúng rồi, cô ấy đang đợi tôi ở nhà mà."
        -> check_buster
    - else:
        -> check_buster
}

=== check_buster ===
{
    - knows_about_buster: 
        + [Chú chó của anh, Buster đúng không. Hãy nhớ dáng vẻ của nó mỗi lần nó đứng ở cửa đợi anh về.]
        ~ calm2 = true
        NGƯỜI CẮM TRẠI: "Phải rồi, tôi còn nó nữa mà, chết tiệt tôi nhớ nó quá đi mất."
        -> check_calm
    - else:
        -> check_calm
}

=== check_calm ===
{
    - calm1 && calm2:
        NGƯỜI CẮM TRẠI: "Được rồi, tôi bình tĩnh lại rồi. Chết tiệt cái giọng nói trong đầu nãy giờ cứ lảm nhảm liên tục làm tôi đau đầu chết mất."
        NGƯỜI CẮM TRẠI: "Giờ tôi phải làm gì đây hả anh kiểm lâm?"
        -> final_ritual
    - else:
        -> bad_ending_rogue
}

=== final_ritual ===

{
    - knows_about_story:
        + [Nếu chúng ta có thể đảo ngược những gì nhóm cắm trại kia đã làm, tôi nghĩ chúng ta có thể phong ấn thứ đó lại.]
            -> ritual_explaination
            
    - else:
        + [Để tôi xem chúng ta nên làm gì...] -> final_ritual
}

=== ritual_explaination ===
NGƯỜI CẮM TRẠI: "Ra là vậy, chiếc băng dán ở cửa thì tôi biết, nhưng còn quyển sách thì rốt cuộc là cuốn nào mới được chứ?"
+ [Ở trên bàn có những cuốn sách nào, anh thử kể đặc điểm của chúng cho tôi xem.]
    ~ tp += 15
    NGƯỜI CẮM TRẠI: "Có 3 cuốn, một cuốn có hình ngôi sao 6 cánh, một cuốn thì có hình mặt con gì đó với 2 sừng khá dài, cuốn thứ ba thì là hình tam giác với con mắt ở giữa."
    NGƯỜI CẮM TRẠI: "Tôi nên lấy cuốn nào... AAAHH chết tiệt, CÚT RA KHỎI ĐẦU TAO MAU!!" #SFX:Drop_Sound
    ++ [Anh còn ổn chứ?]
        NGƯỜI CẮM TRẠI: "Tôi không sao, nó liên tục quấy rối tôi bằng những ngôn ngữ kì lạ, đầu tôi giờ rối tung quá, chết tiệt."
        NGƯỜI CẮM TRẠI: "Nhanh lên, tôi phải lấy cuốn nào để đặt vào cái vòng phép thuật kia vậy?" 
        -> book_choice

=== book_choice ===
+ [Cuốn có hình ngôi sao thử xem!]
    NGƯỜI CẮM TRẠI: "Được để tôi thử xem!" -> bad_ending_possession
+ [Cuốn có thứ 2 sừng!]
    NGƯỜI CẮM TRẠI: "Được để tôi thử xem!" -> bad_ending_possession
+ [Cuốn có hình tam giác!]
    NGƯỜI CẮM TRẠI: "Được để tôi thử xem!" -> bad_ending_possession
+ {knows_about_wings} [Không có cuốn nào hình đôi cánh hay con chim gì sao? Ở kệ sách kia còn quyển nào không?]
    NGƯỜI CẮM TRẠI: "Hả, tại sao... À không tôi sẽ tin tưởng anh!"
    NGƯỜI CẮM TRẠI: "(Sột soạt) (Lạch cạch)"
    NGƯỜI CẮM TRẠI: "À há! Có một cuốn có biểu tượng gần giống đôi cánh này, có lẽ chính là quyển chúng ta cần."
    NGƯỜI CẮM TRẠI: "Cái gì, không phải nó sao? Ngươi không thể lừa được ta lần nữa đâu, ta đã tỉnh táo rồi."
    NGƯỜI CẮM TRẠI: "Yên phận ở đây đi!" -> monster_sealing

=== monster_sealing ===
+ [Sau khi đặt cuốn sách lại vào vòng tròn, mau ra ngoài và dán lại băng dán vào mép cửa!]
    NGƯỜI CẮM TRẠI: "Xong rồi, giờ-"
    NGƯỜI CẮM TRẠI: "AAAAAAAAAAHHHHHHHHHH" #SFX:Camper_Screaming
    NGƯỜI CẮM TRẠI: "Đầu tôi- đau... ĐAU QUÁ!!!!"
    ++ [Sắp thành công rồi, cố lên một chút nữa thôi!]
        -> monster_fighting

=== monster_fighting ===
NGƯỜI CẮM TRẠI: "Ch-Chết tiệt, mẹ ơi đầu tôi... CÚT RA KHỎI ĐẦU CỦA TA ĐI TÊN KHỐN!"
+ [Nhớ lại những gì anh cần phải trở về với đi!]
    NGƯỜI CẮM TRẠI: "..."
    ++ [Gia đình!]
        NGƯỜI CẮM TRẠI: "..."
        +++ [Người vợ của anh!]
            NGƯỜI CẮM TRẠI: "..."
            ++++ [Chú chó của anh nữa!]
                NGƯỜI CẮM TRẠI: "..."
                NGƯỜI CẮM TRẠI: "..."
                NGƯỜI CẮM TRẠI: "An...Anh thật là một kẻ lắm mồm quá đấy!"
                NGƯỜI CẮM TRẠI: "Nhưng nó thực sự giú... giúp tôi có th...êm sức mạnh đấy!"
                NGƯỜI CẮM TRẠI: "(Bộp bộp)" #SFX:Running_Sound
                NGƯỜI CẮM TRẠI: "CHẾT ĐI ĐỒ KHỐN NẠN!!!"
                NGƯỜI CẮM TRẠI: "Ủa sao không có chuyện-"
                (Tiếng hét quái quỷ) #SFX:Monster_Screaming
                NGƯỜI CẮM TRẠI: "Chết tiệt cái tiếng hét kinh dị gì thế này."
                NGƯỜI CẮM TRẠI: "Hả... giọng nói trong đầu tôi biến mất rồi..."
                NGƯỜI CẮM TRẠI: "Hahah... thật không thể tin được những gì tôi vừa trải qua đấy." -> secret_ending_success

=== read_book_wings ===
"Trong thuở hồng hoang, khi bóng tối muốn nuốt chửng cả bầu trời..." #WAIT:2
"Một thực thể với đôi cánh bạc rực rỡ đã giáng lâm, tay cầm thanh gươm rèn từ ánh chớp." #WAIT:3
"Ngài không tiêu diệt bằng cái chết, mà bằng sự giam cầm vĩnh cửu." #WAIT:2
"Dưới chân ngài, kẻ kiêu ngạo nhất từ vực thẳm đã phải quỳ xuống, tiếng gầm thét bị khóa lại bởi những xiềng xích của ánh sáng trắng." #WAIT:3
"Chừng nào đôi cánh ấy còn dang rộng trong tâm trí kẻ được chọn, mầm mống của quỷ dữ sẽ mãi mãi bị giam hãm trong hư không." #WAIT:3
~ knows_about_wings = true
-> DONE

=== read_book_story ===
"Họ kể rằng, tại một thung lũng sương mù, có một trí tuệ vượt xa thời đại." #WAIT:2
"Trong quá trình tìm kiếm tri thức, hắn lại tìm được tình yêu của cuộc đời mình." #WAIT:2
"Tình yêu tuy đẹp và lãng mạn đến thế, và lẽ ra nên là một câu chuyện hạnh phúc về ngôi nhà và những đứa trẻ, nhưng cuộc sống lại rất khó khăn cho cặp vợ chồng son."#WAIT:3
"Chàng vì mong mỏi danh tiếng và tiền tài mà đã đầu tư tiền bạc hoàn toàn vào những thí nghiệm khoa học, dần dần bòn rút tài sản của hai vợ chồng đến kiệt quệ."#WAIT:3
"Nàng vì chàng mà đã làm đủ mọi việc để kiếm thêm thu nhập, từ những công việc dơ bẩn nhất đến những công việc nặng nhọc nhất."#WAIT:2
"Nhưng vì tình yêu của đời mình, cũng như đứa con chưa chào đời, nàng cắn răng chịu đựng để đặt niềm tin vào người chồng mù quáng."#WAIT:2
"Để rồi đến khi nàng chạm tới giới hạn của một người phụ nữ, tai hoạ cuối cùng cũng phải xảy ra."#WAIT:2
"Nàng bị liệt nửa cơ thể dưới sau khi kiệt sức mà ngã từ trên đồi xuống trong lúc đang hái quả dại, cùng với đứa bé còn chưa kịp nhìn thấy ánh mặt trời."#WAIT:3
"Chuyện ấy khiến nàng suy sụp tinh thần, để rồi trở thành người tàn phế nằm trên giường suốt từ lúc tuyết rơi cho đến lúc mùa vụ mới lại sang."#WAIT:3
"Người chồng sau khi biết chuyện cũng chỉ tự biết trách bản thân mình, để rồi lại đắm chìm vào khoa học một lần nữa."#WAIT:2
"Hắn điên cuồng tìm kiếm tri thức và tạo ra những phương thuốc để phá vỡ quy luật của sự sống và thiên nhiên." #WAIT:2
"Ngày càng có nhiều hiện tượng kì lạ, những cành cây trụi lá dù chưa đến mùa thu, những xác động vật hoang dã ngày càng xuất hiện nhiều ở khắp nơi."#WAIT:3
"Nhiều người truyền tai nhau rằng đã nghe gã nhà khoa học liên tục lẩm bẩm thứ gọi là giả kim thuật, rằng hắn cần vật tế sống để hồi sinh đứa con đã mất."#WAIT:3
"Lo sợ rằng đến một lúc nào đấy hắn sẽ giết người, cả làng đã bàn bạc với nhau để loại bỏ nhà khoa học ra khỏi làng."#WAIT:2
"Đêm xuống, khi khung cảnh chỉ còn tiếng gió thổi khẽ qua mang tai, và tiếng những tán lá dần rụng theo khỏi cành cây."#WAIT:2
"Một ngọn lửa đã thắp sáng cả một vùng trời, nhưng ngọn lửa đó lại từ nhà của tên nhà khoa học kia mà bùng lên dữ dội."#WAIT:2
"Dân làng đã tàn ác đến mức quyết định sẽ giết cả người chồng và người vợ vô tội, để đảm bảo rằng hậu duệ của kẻ điên kia sẽ không tồn tại."#WAIT:3
"Ngọn lửa kia đã thiêu rụi những năm tháng hạnh phúc, những kỉ niệm ngọt ngào của 2 con người."#WAIT:2
"Biến chúng thành những tiếng kêu la thảm thiết và tiếng kêu bất lực của ai kia."#WAIT:2
"Thế nhưng, người chồng của gia đình lại không có ở đó. Hắn đang trên đường tìm kiếm nguyên vật liệu cho thứ thuốc mà hắn gọi là thuốc tăng cường sức khoẻ."#WAIT:3
"Chứng kiến cảnh tượng kinh khủng đến tột độ, hắn dường như đã quẫn trí, hoá điên trước khi hét lên đau đớn mà ai oán vô cùng, vang vọng cả một bầu trời đêm."#WAIT:3
"Khi ngọn lửa thiêu rụi người phụ nữ duy nhất hắn yêu thương, kẻ ấy đã biến mình thành chính thứ thí nghiệm bệnh hoạn và hoá thành sự hiện thân của tà ác." #WAIT:3
"Hắn tàn sát gần như cả ngôi làng trong cơn điên loạn, dường như chẳng thứ gì có thể ngăn cản hắn lúc này."#WAIT:2
"Cho đến một lúc nào đó hắn bỗng nhiên trở nên đau đớn, tay ôm đầu mà gào thét lên như một con thú."#WAIT:2
"Ngay lập tức những người còn sống sót đã tận dụng cơ hội để đâm xuyên trái tim vụn vỡ của một thứ từng là con người."#WAIT:2
"Dẫu vậy có vẻ sự hận thù vẫn chưa dừng lại, khi hắn chết đã hoá thành loài quỷ dữ ám lấy nơi này."#WAIT:2
"Dịch bệnh tràn lan, muôn thú bỏ chạy, nguồn nước ô nhiễm, nhiều người cũng đã dần hoá điên đến mức giết người."#WAIT:2
"Họ buộc phải mời những vị thánh thần để trừ tà, lấy lại sự bình yên nơi ngôi làng vốn dĩ từng có."#WAIT:2
"Tuy rằng đã thành công, song vì quá sợ con quỷ kia mà dần dần mọi người đã di cư khỏi ngôi làng, dần dần chẳng còn bóng dáng của ai còn sống ở đây nữa."#WAIT:3
"Chỉ còn con quỷ, chỉ còn sự hận thù, chỉ còn phong ấn giam giữ hắn, thì vẫn mãi còn ở đó, bảo vệ con người khỏi thứ gọi là ác quỷ." #WAIT:5
~ knows_about_story = true
-> DONE

=== secret_ending_success ===
+ [Có vẻ như chúng ta đã phong ấn được thứ kia rồi! Anh làm tốt lắm]
NGƯỜI CẮM TRẠI: "Cảm ơn anh đã giúp tôi! Anh kiểm lâm!"
#EVENT:Dimmed_Screen
SECRET ENDING 
#EVENT:Game_Over
-> END

=== good_ending_normal ===
NGƯỜI CẮM TRẠI: "Tôi thoát rồi! Anh kiểm lâm ơi, cảm ơn anh nhiều."
#EVENT:Dimmed_Screen
GOOD ENDING
#EVENT:Game_Over
-> END

=== bad_ending_caught ===
NGƯỜI CẮM TRẠI: "Hả! Có tiếng gì vậy?" #EVENT:StaticCamera_Cam1
NGƯỜI CẮM TRẠI: "Này, ai ở đ-" #SFX:Drop_Sound

+ [Này, anh còn ở đó chứ?]
    "..."
    ++ [Alo, này anh bạn, anh đâu rồi?]
        "..."
        #EVENT:Hide_Camper
        #EVENT:DeadBody_Cam1
        #EVENT:ClearCamera_Cam1
        #EVENT:WaitingForCam1
        #WAIT:4
        -> DONE

=== reaction_caught_cam1 ===
"..."
ANH KIỂM LÂM: "... Chết tiệt"
#EVENT:Dimmed_Screen
BAD ENDING
#EVENT:Game_Over
-> END

=== bad_ending_rogue ===
NGƯỜI CẮM TRẠI: "CHẾT TIỆT, PHẢI MAU CHÓNG THOÁT KHỎI ĐÂY-"
#MOVE:Waypoint_BigTree
#EVENT:StaticCamera_Cam7

+ [Này, anh bạn, anh đâu rồi!]
    "..."
    ++ [Chết tiệt, chuyện gì xảy ra với anh rồi!]
        "..."
        #EVENT:Hide_Camper
        #EVENT:ClearCamera_Cam7
        #EVENT:DeadBody_Cam7
        #EVENT:ClearCamera_Cam7
        #EVENT:WaitingForCam7
        #WAIT:4
        -> DONE

=== reaction_rogue_cam7 ===
"..."
ANH KIỂM LÂM: "... Chết tiệt"
#WAIT:4
#EVENT:Dimmed_Screen
BAD ENDING
#EVENT:Game_Over
-> END

=== bad_ending_possession ===
#SFX:Monster_Screaming #WAIT:5
RADIO: "HAHAHAHAHAHAHAHAHAHAHAHA"
RADIO: "Cảm ơn vì đã giải phóng cho ta." #SFX:Monster_Laughing
#EVENT:StaticCamera_All
#EVENT:Hide_Camper
#EVENT:DeadBody_Cam4
RADIO: "Giờ để ta trả lại công ơn cho các ngươi nhé!"
#WAIT:4
RADIO: "Ta có quà cho ngươi đấy!"
#EVENT:ClearCamera_All 
#EVENT:WaitingForCam4
-> DONE 

=== reaction_possession_cam4 ===
#WAIT:4
"..."
ANH KIỂM LÂM: "... Chết tiệt"
#EVENT:Monster_BadEndPos
-> DONE

=== possession_death_moment ===
#EVENT:Black_Screen
BAD ENDING
#EVENT:Game_Over
-> END
