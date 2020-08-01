<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/dataproc/v1beta2/clusters.proto

namespace GPBMetadata\Google\Cloud\Dataproc\V1Beta2;

class Clusters
{
    public static $is_initialized = false;

    public static function initOnce() {
        $pool = \Google\Protobuf\Internal\DescriptorPool::getGeneratedPool();

        if (static::$is_initialized == true) {
          return;
        }
        \GPBMetadata\Google\Api\Annotations::initOnce();
        \GPBMetadata\Google\Api\Client::initOnce();
        \GPBMetadata\Google\Api\FieldBehavior::initOnce();
        \GPBMetadata\Google\Api\Resource::initOnce();
        \GPBMetadata\Google\Cloud\Dataproc\V1Beta2\Shared::initOnce();
        \GPBMetadata\Google\Longrunning\Operations::initOnce();
        \GPBMetadata\Google\Protobuf\Duration::initOnce();
        \GPBMetadata\Google\Protobuf\FieldMask::initOnce();
        \GPBMetadata\Google\Protobuf\Timestamp::initOnce();
        $pool->internalAddGeneratedFile(hex2bin(
            "0a82450a2c676f6f676c652f636c6f75642f6461746170726f632f763162" .
            "657461322f636c7573746572732e70726f746f121d676f6f676c652e636c" .
            "6f75642e6461746170726f632e763162657461321a17676f6f676c652f61" .
            "70692f636c69656e742e70726f746f1a1f676f6f676c652f6170692f6669" .
            "656c645f6265686176696f722e70726f746f1a19676f6f676c652f617069" .
            "2f7265736f757263652e70726f746f1a2a676f6f676c652f636c6f75642f" .
            "6461746170726f632f763162657461322f7368617265642e70726f746f1a" .
            "23676f6f676c652f6c6f6e6772756e6e696e672f6f7065726174696f6e73" .
            "2e70726f746f1a1e676f6f676c652f70726f746f6275662f647572617469" .
            "6f6e2e70726f746f1a20676f6f676c652f70726f746f6275662f6669656c" .
            "645f6d61736b2e70726f746f1a1f676f6f676c652f70726f746f6275662f" .
            "74696d657374616d702e70726f746f22e6030a07436c757374657212170a" .
            "0a70726f6a6563745f69641801200128094203e0410212190a0c636c7573" .
            "7465725f6e616d651802200128094203e0410212410a06636f6e66696718" .
            "032001280b322c2e676f6f676c652e636c6f75642e6461746170726f632e" .
            "763162657461322e436c7573746572436f6e6669674203e0410212470a06" .
            "6c6162656c7318082003280b32322e676f6f676c652e636c6f75642e6461" .
            "746170726f632e763162657461322e436c75737465722e4c6162656c7345" .
            "6e7472794203e0410112410a0673746174757318042001280b322c2e676f" .
            "6f676c652e636c6f75642e6461746170726f632e763162657461322e436c" .
            "75737465725374617475734203e0410312490a0e7374617475735f686973" .
            "746f727918072003280b322c2e676f6f676c652e636c6f75642e64617461" .
            "70726f632e763162657461322e436c75737465725374617475734203e041" .
            "0312190a0c636c75737465725f757569641806200128094203e041031243" .
            "0a076d65747269637318092001280b322d2e676f6f676c652e636c6f7564" .
            "2e6461746170726f632e763162657461322e436c75737465724d65747269" .
            "63734203e041031a2d0a0b4c6162656c73456e747279120b0a036b657918" .
            "0120012809120d0a0576616c75651802200128093a0238012281080a0d43" .
            "6c7573746572436f6e666967121a0a0d636f6e6669675f6275636b657418" .
            "01200128094203e0410112500a126763655f636c75737465725f636f6e66" .
            "696718082001280b322f2e676f6f676c652e636c6f75642e646174617072" .
            "6f632e763162657461322e476365436c7573746572436f6e6669674203e0" .
            "4101124e0a0d6d61737465725f636f6e66696718092001280b32322e676f" .
            "6f676c652e636c6f75642e6461746170726f632e763162657461322e496e" .
            "7374616e636547726f7570436f6e6669674203e04101124e0a0d776f726b" .
            "65725f636f6e666967180a2001280b32322e676f6f676c652e636c6f7564" .
            "2e6461746170726f632e763162657461322e496e7374616e636547726f75" .
            "70436f6e6669674203e0410112580a177365636f6e646172795f776f726b" .
            "65725f636f6e666967180c2001280b32322e676f6f676c652e636c6f7564" .
            "2e6461746170726f632e763162657461322e496e7374616e636547726f75" .
            "70436f6e6669674203e04101124b0a0f736f6674776172655f636f6e6669" .
            "67180d2001280b322d2e676f6f676c652e636c6f75642e6461746170726f" .
            "632e763162657461322e536f667477617265436f6e6669674203e0410112" .
            "4d0a106c6966656379636c655f636f6e666967180e2001280b322e2e676f" .
            "6f676c652e636c6f75642e6461746170726f632e763162657461322e4c69" .
            "66656379636c65436f6e6669674203e04101125c0a16696e697469616c69" .
            "7a6174696f6e5f616374696f6e73180b2003280b32372e676f6f676c652e" .
            "636c6f75642e6461746170726f632e763162657461322e4e6f6465496e69" .
            "7469616c697a6174696f6e416374696f6e4203e04101124f0a11656e6372" .
            "797074696f6e5f636f6e666967180f2001280b322f2e676f6f676c652e63" .
            "6c6f75642e6461746170726f632e763162657461322e456e637279707469" .
            "6f6e436f6e6669674203e0410112510a126175746f7363616c696e675f63" .
            "6f6e66696718102001280b32302e676f6f676c652e636c6f75642e646174" .
            "6170726f632e763162657461322e4175746f7363616c696e67436f6e6669" .
            "674203e04101124b0a0f656e64706f696e745f636f6e6669671811200128" .
            "0b322d2e676f6f676c652e636c6f75642e6461746170726f632e76316265" .
            "7461322e456e64706f696e74436f6e6669674203e04101124b0a0f736563" .
            "75726974795f636f6e66696718122001280b322d2e676f6f676c652e636c" .
            "6f75642e6461746170726f632e763162657461322e536563757269747943" .
            "6f6e6669674203e0410112500a12676b655f636c75737465725f636f6e66" .
            "696718132001280b322f2e676f6f676c652e636c6f75642e646174617072" .
            "6f632e763162657461322e476b65436c7573746572436f6e6669674203e0" .
            "41012298020a10476b65436c7573746572436f6e666967127c0a206e616d" .
            "657370616365645f676b655f6465706c6f796d656e745f74617267657418" .
            "012001280b324d2e676f6f676c652e636c6f75642e6461746170726f632e" .
            "763162657461322e476b65436c7573746572436f6e6669672e4e616d6573" .
            "7061636564476b654465706c6f796d656e745461726765744203e041011a" .
            "85010a1d4e616d65737061636564476b654465706c6f796d656e74546172" .
            "67657412440a127461726765745f676b655f636c75737465721801200128" .
            "094228e04101fa41220a20636f6e7461696e65722e676f6f676c65617069" .
            "732e636f6d2f436c7573746572121e0a11636c75737465725f6e616d6573" .
            "706163651802200128094203e0410122bf010a0e456e64706f696e74436f" .
            "6e66696712550a0a687474705f706f72747318012003280b323c2e676f6f" .
            "676c652e636c6f75642e6461746170726f632e763162657461322e456e64" .
            "706f696e74436f6e6669672e48747470506f727473456e7472794203e041" .
            "0312240a17656e61626c655f687474705f706f72745f6163636573731802" .
            "200128084203e041011a300a0e48747470506f727473456e747279120b0a" .
            "036b6579180120012809120d0a0576616c75651802200128093a02380122" .
            "2c0a114175746f7363616c696e67436f6e66696712170a0a706f6c696379" .
            "5f7572691801200128094203e0410122340a10456e6372797074696f6e43" .
            "6f6e66696712200a136763655f70645f6b6d735f6b65795f6e616d651801" .
            "200128094203e0410122a9030a10476365436c7573746572436f6e666967" .
            "12150a087a6f6e655f7572691801200128094203e0410112180a0b6e6574" .
            "776f726b5f7572691802200128094203e04101121b0a0e7375626e657477" .
            "6f726b5f7572691806200128094203e04101121d0a10696e7465726e616c" .
            "5f69705f6f6e6c791807200128084203e04101121c0a0f73657276696365" .
            "5f6163636f756e741808200128094203e0410112230a1673657276696365" .
            "5f6163636f756e745f73636f7065731803200328094203e04101120c0a04" .
            "74616773180420032809124f0a086d6574616461746118052003280b323d" .
            "2e676f6f676c652e636c6f75642e6461746170726f632e76316265746132" .
            "2e476365436c7573746572436f6e6669672e4d65746164617461456e7472" .
            "7912550a147265736572766174696f6e5f616666696e697479180b200128" .
            "0b32322e676f6f676c652e636c6f75642e6461746170726f632e76316265" .
            "7461322e5265736572766174696f6e416666696e6974794203e041011a2f" .
            "0a0d4d65746164617461456e747279120b0a036b6579180120012809120d" .
            "0a0576616c75651802200128093a02380122a4030a13496e7374616e6365" .
            "47726f7570436f6e666967121a0a0d6e756d5f696e7374616e6365731801" .
            "200128054203e04101121b0a0e696e7374616e63655f6e616d6573180220" .
            "0328094203e0410312160a09696d6167655f7572691803200128094203e0" .
            "4101121d0a106d616368696e655f747970655f7572691804200128094203" .
            "e0410112430a0b6469736b5f636f6e66696718052001280b32292e676f6f" .
            "676c652e636c6f75642e6461746170726f632e763162657461322e446973" .
            "6b436f6e6669674203e04101121b0a0e69735f707265656d707469626c65" .
            "1806200128084203e0410312540a146d616e616765645f67726f75705f63" .
            "6f6e66696718072001280b32312e676f6f676c652e636c6f75642e646174" .
            "6170726f632e763162657461322e4d616e6167656447726f7570436f6e66" .
            "69674203e04103124b0a0c616363656c657261746f727318082003280b32" .
            "302e676f6f676c652e636c6f75642e6461746170726f632e763162657461" .
            "322e416363656c657261746f72436f6e6669674203e0410112180a106d69" .
            "6e5f6370755f706c6174666f726d18092001280922630a124d616e616765" .
            "6447726f7570436f6e66696712230a16696e7374616e63655f74656d706c" .
            "6174655f6e616d651801200128094203e0410312280a1b696e7374616e63" .
            "655f67726f75705f6d616e616765725f6e616d651802200128094203e041" .
            "03224c0a11416363656c657261746f72436f6e666967121c0a1461636365" .
            "6c657261746f725f747970655f75726918012001280912190a1161636365" .
            "6c657261746f725f636f756e7418022001280522610a0a4469736b436f6e" .
            "666967121b0a0e626f6f745f6469736b5f747970651803200128094203e0" .
            "4101121e0a11626f6f745f6469736b5f73697a655f676218012001280542" .
            "03e0410112160a0e6e756d5f6c6f63616c5f737364731802200128052283" .
            "020a0f4c6966656379636c65436f6e66696712370a0f69646c655f64656c" .
            "6574655f74746c18012001280b32192e676f6f676c652e70726f746f6275" .
            "662e4475726174696f6e4203e04101123b0a106175746f5f64656c657465" .
            "5f74696d6518022001280b321a2e676f6f676c652e70726f746f6275662e" .
            "54696d657374616d704203e04101480012390a0f6175746f5f64656c6574" .
            "655f74746c18032001280b32192e676f6f676c652e70726f746f6275662e" .
            "4475726174696f6e4203e04101480012380a0f69646c655f73746172745f" .
            "74696d6518042001280b321a2e676f6f676c652e70726f746f6275662e54" .
            "696d657374616d704203e0410342050a0374746c22580a0e536563757269" .
            "7479436f6e66696712460a0f6b65726265726f735f636f6e666967180120" .
            "01280b322d2e676f6f676c652e636c6f75642e6461746170726f632e7631" .
            "62657461322e4b65726265726f73436f6e6669672290040a0e4b65726265" .
            "726f73436f6e666967121c0a0f656e61626c655f6b65726265726f731801" .
            "200128084203e0410112280a1b726f6f745f7072696e636970616c5f7061" .
            "7373776f72645f7572691802200128094203e0410212180a0b6b6d735f6b" .
            "65795f7572691803200128094203e0410212190a0c6b657973746f72655f" .
            "7572691804200128094203e04101121b0a0e747275737473746f72655f75" .
            "72691805200128094203e0410112220a156b657973746f72655f70617373" .
            "776f72645f7572691806200128094203e04101121d0a106b65795f706173" .
            "73776f72645f7572691807200128094203e0410112240a17747275737473" .
            "746f72655f70617373776f72645f7572691808200128094203e041011224" .
            "0a1763726f73735f7265616c6d5f74727573745f7265616c6d1809200128" .
            "094203e0410112220a1563726f73735f7265616c6d5f74727573745f6b64" .
            "63180a200128094203e04101122b0a1e63726f73735f7265616c6d5f7472" .
            "7573745f61646d696e5f736572766572180b200128094203e0410112320a" .
            "2563726f73735f7265616c6d5f74727573745f7368617265645f70617373" .
            "776f72645f757269180c200128094203e04101121b0a0e6b64635f64625f" .
            "6b65795f757269180d200128094203e04101121f0a127467745f6c696665" .
            "74696d655f686f757273180e200128054203e0410112120a057265616c6d" .
            "180f200128094203e0410122730a184e6f6465496e697469616c697a6174" .
            "696f6e416374696f6e121c0a0f65786563757461626c655f66696c651801" .
            "200128094203e0410212390a11657865637574696f6e5f74696d656f7574" .
            "18022001280b32192e676f6f676c652e70726f746f6275662e4475726174" .
            "696f6e4203e0410122b4030a0d436c757374657253746174757312460a05" .
            "737461746518012001280e32322e676f6f676c652e636c6f75642e646174" .
            "6170726f632e763162657461322e436c75737465725374617475732e5374" .
            "6174654203e0410312130a0664657461696c1802200128094203e0410312" .
            "390a1073746174655f73746172745f74696d6518032001280b321a2e676f" .
            "6f676c652e70726f746f6275662e54696d657374616d704203e04103124c" .
            "0a08737562737461746518042001280e32352e676f6f676c652e636c6f75" .
            "642e6461746170726f632e763162657461322e436c757374657253746174" .
            "75732e53756273746174654203e04103227f0a055374617465120b0a0755" .
            "4e4b4e4f574e1000120c0a084352454154494e471001120b0a0752554e4e" .
            "494e47100212090a054552524f521003120c0a0844454c4554494e471004" .
            "120c0a085550444154494e471005120c0a0853544f5050494e471006120b" .
            "0a0753544f505045441007120c0a085354415254494e471008223c0a0853" .
            "75627374617465120f0a0b554e5350454349464945441000120d0a09554e" .
            "4845414c544859100112100a0c5354414c455f535441545553100222fe01" .
            "0a0e536f667477617265436f6e666967121a0a0d696d6167655f76657273" .
            "696f6e1801200128094203e0410112560a0a70726f706572746965731802" .
            "2003280b323d2e676f6f676c652e636c6f75642e6461746170726f632e76" .
            "3162657461322e536f667477617265436f6e6669672e50726f7065727469" .
            "6573456e7472794203e0410112450a136f7074696f6e616c5f636f6d706f" .
            "6e656e747318032003280e32282e676f6f676c652e636c6f75642e646174" .
            "6170726f632e763162657461322e436f6d706f6e656e741a310a0f50726f" .
            "70657274696573456e747279120b0a036b6579180120012809120d0a0576" .
            "616c75651802200128093a02380122a4020a0e436c75737465724d657472" .
            "69637312540a0c686466735f6d65747269637318012003280b323e2e676f" .
            "6f676c652e636c6f75642e6461746170726f632e763162657461322e436c" .
            "75737465724d6574726963732e486466734d657472696373456e74727912" .
            "540a0c7961726e5f6d65747269637318022003280b323e2e676f6f676c65" .
            "2e636c6f75642e6461746170726f632e763162657461322e436c75737465" .
            "724d6574726963732e5961726e4d657472696373456e7472791a320a1048" .
            "6466734d657472696373456e747279120b0a036b6579180120012809120d" .
            "0a0576616c75651802200128033a0238011a320a105961726e4d65747269" .
            "6373456e747279120b0a036b6579180120012809120d0a0576616c756518" .
            "02200128033a023801229b010a14437265617465436c7573746572526571" .
            "7565737412170a0a70726f6a6563745f69641801200128094203e0410212" .
            "130a06726567696f6e1803200128094203e04102123c0a07636c75737465" .
            "7218022001280b32262e676f6f676c652e636c6f75642e6461746170726f" .
            "632e763162657461322e436c75737465724203e0410212170a0a72657175" .
            "6573745f69641804200128094203e0410122b3020a14557064617465436c" .
            "75737465725265717565737412170a0a70726f6a6563745f696418012001" .
            "28094203e0410212130a06726567696f6e1805200128094203e041021219" .
            "0a0c636c75737465725f6e616d651802200128094203e04102123c0a0763" .
            "6c757374657218032001280b32262e676f6f676c652e636c6f75642e6461" .
            "746170726f632e763162657461322e436c75737465724203e0410212450a" .
            "1d677261636566756c5f6465636f6d6d697373696f6e5f74696d656f7574" .
            "18062001280b32192e676f6f676c652e70726f746f6275662e4475726174" .
            "696f6e4203e0410112340a0b7570646174655f6d61736b18042001280b32" .
            "1a2e676f6f676c652e70726f746f6275662e4669656c644d61736b4203e0" .
            "410212170a0a726571756573745f69641807200128094203e04101229301" .
            "0a1444656c657465436c75737465725265717565737412170a0a70726f6a" .
            "6563745f69641801200128094203e0410212130a06726567696f6e180320" .
            "0128094203e0410212190a0c636c75737465725f6e616d65180220012809" .
            "4203e0410212190a0c636c75737465725f757569641804200128094203e0" .
            "410112170a0a726571756573745f69641805200128094203e04101225c0a" .
            "11476574436c75737465725265717565737412170a0a70726f6a6563745f" .
            "69641801200128094203e0410212130a06726567696f6e18032001280942" .
            "03e0410212190a0c636c75737465725f6e616d651802200128094203e041" .
            "022289010a134c697374436c7573746572735265717565737412170a0a70" .
            "726f6a6563745f69641801200128094203e0410212130a06726567696f6e" .
            "1804200128094203e0410212130a0666696c7465721805200128094203e0" .
            "410112160a09706167655f73697a651802200128054203e0410112170a0a" .
            "706167655f746f6b656e1803200128094203e0410122730a144c69737443" .
            "6c757374657273526573706f6e7365123d0a08636c757374657273180120" .
            "03280b32262e676f6f676c652e636c6f75642e6461746170726f632e7631" .
            "62657461322e436c75737465724203e04103121c0a0f6e6578745f706167" .
            "655f746f6b656e1802200128094203e0410322610a16446961676e6f7365" .
            "436c75737465725265717565737412170a0a70726f6a6563745f69641801" .
            "200128094203e0410212130a06726567696f6e1803200128094203e04102" .
            "12190a0c636c75737465725f6e616d651802200128094203e0410222310a" .
            "16446961676e6f7365436c7573746572526573756c747312170a0a6f7574" .
            "7075745f7572691801200128094203e0410322fd010a1352657365727661" .
            "74696f6e416666696e697479125e0a18636f6e73756d655f726573657276" .
            "6174696f6e5f7479706518012001280e32372e676f6f676c652e636c6f75" .
            "642e6461746170726f632e763162657461322e5265736572766174696f6e" .
            "416666696e6974792e547970654203e0410112100a036b65791802200128" .
            "094203e0410112130a0676616c7565731803200328094203e04101225f0a" .
            "045479706512140a10545950455f554e535045434946494544100012120a" .
            "0e4e4f5f5245534552564154494f4e100112130a0f414e595f5245534552" .
            "564154494f4e100212180a1453504543494649435f524553455256415449" .
            "4f4e100332e70d0a11436c7573746572436f6e74726f6c6c65721291020a" .
            "0d437265617465436c757374657212332e676f6f676c652e636c6f75642e" .
            "6461746170726f632e763162657461322e437265617465436c7573746572" .
            "526571756573741a1d2e676f6f676c652e6c6f6e6772756e6e696e672e4f" .
            "7065726174696f6e22ab0182d3e493024322382f763162657461322f7072" .
            "6f6a656374732f7b70726f6a6563745f69647d2f726567696f6e732f7b72" .
            "6567696f6e7d2f636c7573746572733a07636c7573746572da411b70726f" .
            "6a6563745f69642c20726567696f6e2c20636c7573746572ca41410a0743" .
            "6c75737465721236676f6f676c652e636c6f75642e6461746170726f632e" .
            "763162657461322e436c75737465724f7065726174696f6e4d6574616461" .
            "746112bb020a0d557064617465436c757374657212332e676f6f676c652e" .
            "636c6f75642e6461746170726f632e763162657461322e55706461746543" .
            "6c7573746572526571756573741a1d2e676f6f676c652e6c6f6e6772756e" .
            "6e696e672e4f7065726174696f6e22d50182d3e493025232472f76316265" .
            "7461322f70726f6a656374732f7b70726f6a6563745f69647d2f72656769" .
            "6f6e732f7b726567696f6e7d2f636c7573746572732f7b636c7573746572" .
            "5f6e616d657d3a07636c7573746572da413670726f6a6563745f69642c20" .
            "726567696f6e2c20636c75737465725f6e616d652c20636c75737465722c" .
            "207570646174655f6d61736bca41410a07436c75737465721236676f6f67" .
            "6c652e636c6f75642e6461746170726f632e763162657461322e436c7573" .
            "7465724f7065726174696f6e4d6574616461746112aa020a0d44656c6574" .
            "65436c757374657212332e676f6f676c652e636c6f75642e646174617072" .
            "6f632e763162657461322e44656c657465436c7573746572526571756573" .
            "741a1d2e676f6f676c652e6c6f6e6772756e6e696e672e4f706572617469" .
            "6f6e22c40182d3e49302492a472f763162657461322f70726f6a65637473" .
            "2f7b70726f6a6563745f69647d2f726567696f6e732f7b726567696f6e7d" .
            "2f636c7573746572732f7b636c75737465725f6e616d657dda412070726f" .
            "6a6563745f69642c20726567696f6e2c20636c75737465725f6e616d65ca" .
            "414f0a15676f6f676c652e70726f746f6275662e456d7074791236676f6f" .
            "676c652e636c6f75642e6461746170726f632e763162657461322e436c75" .
            "737465724f7065726174696f6e4d6574616461746112da010a0a47657443" .
            "6c757374657212302e676f6f676c652e636c6f75642e6461746170726f63" .
            "2e763162657461322e476574436c7573746572526571756573741a262e67" .
            "6f6f676c652e636c6f75642e6461746170726f632e763162657461322e43" .
            "6c7573746572227282d3e493024912472f763162657461322f70726f6a65" .
            "6374732f7b70726f6a6563745f69647d2f726567696f6e732f7b72656769" .
            "6f6e7d2f636c7573746572732f7b636c75737465725f6e616d657dda4120" .
            "70726f6a6563745f69642c20726567696f6e2c20636c75737465725f6e61" .
            "6d6512eb010a0c4c697374436c75737465727312322e676f6f676c652e63" .
            "6c6f75642e6461746170726f632e763162657461322e4c697374436c7573" .
            "74657273526571756573741a332e676f6f676c652e636c6f75642e646174" .
            "6170726f632e763162657461322e4c697374436c75737465727352657370" .
            "6f6e7365227282d3e493023a12382f763162657461322f70726f6a656374" .
            "732f7b70726f6a6563745f69647d2f726567696f6e732f7b726567696f6e" .
            "7d2f636c757374657273da411270726f6a6563745f69642c20726567696f" .
            "6eda411a70726f6a6563745f69642c20726567696f6e2c2066696c746572" .
            "12ba020a0f446961676e6f7365436c757374657212352e676f6f676c652e" .
            "636c6f75642e6461746170726f632e763162657461322e446961676e6f73" .
            "65436c7573746572526571756573741a1d2e676f6f676c652e6c6f6e6772" .
            "756e6e696e672e4f7065726174696f6e22d00182d3e493025522502f7631" .
            "62657461322f70726f6a656374732f7b70726f6a6563745f69647d2f7265" .
            "67696f6e732f7b726567696f6e7d2f636c7573746572732f7b636c757374" .
            "65725f6e616d657d3a646961676e6f73653a012ada412070726f6a656374" .
            "5f69642c20726567696f6e2c20636c75737465725f6e616d65ca414f0a15" .
            "676f6f676c652e70726f746f6275662e456d7074791236676f6f676c652e" .
            "636c6f75642e6461746170726f632e763162657461322e436c7573746572" .
            "4f7065726174696f6e4d657461646174611a4bca41176461746170726f63" .
            "2e676f6f676c65617069732e636f6dd2412e68747470733a2f2f7777772e" .
            "676f6f676c65617069732e636f6d2f617574682f636c6f75642d706c6174" .
            "666f726d427b0a21636f6d2e676f6f676c652e636c6f75642e6461746170" .
            "726f632e76316265746132420d436c75737465727350726f746f50015a45" .
            "676f6f676c652e676f6c616e672e6f72672f67656e70726f746f2f676f6f" .
            "676c65617069732f636c6f75642f6461746170726f632f76316265746132" .
            "3b6461746170726f63620670726f746f33"
        ), true);

        static::$is_initialized = true;
    }
}

