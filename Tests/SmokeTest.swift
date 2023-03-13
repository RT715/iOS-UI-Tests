//
//  SmokeTest.swift
//  AppUITests
//
//  Created by Artem Vybornov on 30.11.2021.
//  Copyright © 2021 Open Technologies. All rights reserved.
//

import XCTest

final class SmokeTest: BaseTest {
    
    private let credentials = Credentials()
    private var chatsHelper: ChatsHelper!
    private let apiSupportService = ApiSupportService()
    
    // Screens
    private var authorisationScreen: AuthorisationScreen!
    private var communityPrinciplesScreen: CommunityPrinciplesScreen!
    private var notificationsScreen: NotificationsScreen!
    private var connectContactsScreen: ConnectContactsScren!
    private var onboardingInviteContactsScreen: OnboardingInviteContactsScreen!
    private var accountScreen: AccountScreen!
    private var welcomeScreen: WelcomeScreen!
    private var codeVerificationScreen: CodeVerificationScreen!
    private var newGroupConversationScreen: NewGroupConversationScreen!
    private var mailComposerScreen: MailComposerScreen!
    private var groupChatScreen: GroupChatScreen!
    private var friendsScreen: FriendsScreen!
    private var inviteContactsScreen: InviteContactsScreen!
    private var newConversationsScreen: NewConversationsScreen!
    private var reportMessageScreen: ReportMessageScreen!
    private var otherReasonReportScreen: OtherReasonReportScreen!
    private var reportMessageSuccessScreen: ReportMessageSuccessScreen!
    private var dmChatScreen: DmChatScreen!
    private var messagesScreen: MessagesScreen!
    private var shareToInstagramScreen: ShareToInstagramScreen!
    
    override func setUp() {
        super.setUp()
        self.chatsHelper = ChatsHelper(app: app)
        self.authorisationScreen = AuthorisationScreen(app: app)
        self.communityPrinciplesScreen = CommunityPrinciplesScreen(app: app)
        self.notificationsScreen = NotificationsScreen(app: app)
        self.connectContactsScreen = ConnectContactsScren(app: app)
        self.onboardingInviteContactsScreen = OnboardingInviteContactsScreen(app: app)
        self.accountScreen = AccountScreen(app: app)
        self.welcomeScreen = WelcomeScreen(app: app)
        self.codeVerificationScreen = CodeVerificationScreen(app: app)
        self.newGroupConversationScreen = NewGroupConversationScreen(app: app)
        self.mailComposerScreen = MailComposerScreen(app: app)
        self.groupChatScreen = GroupChatScreen(app: app)
        self.friendsScreen = FriendsScreen(app: app)
        self.inviteContactsScreen = InviteContactsScreen(app: app)
        self.newConversationsScreen = NewConversationsScreen(app: app)
        self.reportMessageScreen = ReportMessageScreen(app: app)
        self.otherReasonReportScreen = OtherReasonReportScreen(app: app)
        self.reportMessageSuccessScreen = ReportMessageSuccessScreen(app: app)
        self.dmChatScreen = DmChatScreen(app: app)
        self.messagesScreen = MessagesScreen(app: app)
        self.shareToInstagramScreen = ShareToInstagramScreen(app: app)
    }
    
    // MARK: - Welcome screen
    
    func test01GoToAuthorizationScreen() {
        welcomeScreen.goToAuthorisationScreen()
        XCTAssert(
            authorisationScreen.phoneNumberStaticText.exists,
            "The element doesn't exist or the 'Get Started' button want's tapped"
        )
    }
    
    // MARK: - Authorisation
    
    func test02SelectCoutry() {
        authorisationScreen.selectCountry(credentials.countryCode)
        XCTAssertEqual(
            authorisationScreen.countrySelectionField.value as! String, credentials.countryCode,
            "The country wasn't selected."
        )
    }
    
    func test03AuthorisationWithoutInternet() {
        turnWifiOff()
        waitForElementToAppear(element: authorisationScreen.countrySelectionField, time: 5)
        authorisationScreen.selectCountry(credentials.countryCode)
        authorisationScreen.typePhoneNumberAndProceed(phoneNumber: credentials.userUnderTestPhoneNumber)
        handleAlert(title: Alert.noInternetConnection.title, buttonToTap: Alert.noInternetConnection.acceptButtonTitle)
        turnWifiOn()
    }
    
    func test04NoInternetMessageVerification() {
        turnWifiOff()
        waitForElementToAppear(element: authorisationScreen.countrySelectionField, time: 5)
        authorisationScreen.selectCountry(credentials.countryCode)
        authorisationScreen.typePhoneNumberAndProceed(phoneNumber: credentials.userUnderTestPhoneNumber)
        verifyTextInAlert(
            title: Alert.noInternetConnection.title,
            text: Alert.noInternetConnection.text
        )
        turnWifiOn()
    }
    
    func test05IncorrectPhoneNumberErrorMessageVerification() {
        authorisationScreen.typePhoneNumberAndProceed(phoneNumber: credentials.userUnderTestPhoneNumber)
        XCTAssertTrue(
            authorisationScreen.incorrectPhoneErrorLabel.exists,
            "There is no error message or the number is correct."
        )
    }
    
    func test06SuccessfulAuthorisation() {
        authorisationScreen.selectCountry(credentials.countryCode)
        authorisationScreen.typePhoneNumberAndProceed(phoneNumber: credentials.userUnderTestPhoneNumber)
        waitForElementToAppear(element: codeVerificationScreen.codeField, time: 5)
        codeVerificationScreen.typeVerificationCodeAndProceed(code: credentials.verificationCode)
        waitForElementToAppear(element: communityPrinciplesScreen.agreeButton, time: 7)
    }
    
    // MARK: - Onboarding. Basic flow
    
    func test07AgreeWithRules() {
        communityPrinciplesScreen.agreeWithRulesAndProceed()
        XCTAssertTrue(
            notificationsScreen.continueButton.exists,
            "The user is not on the 'Notifications' screen or the button doesn't exist."
        )
    }
    
    func test08AllowNotifications() {
        notificationsScreen.allowNotifications()
        handleSystemAlert(title: Alert.allowNotifications.title, buttonToTap: Alert.allowNotifications.acceptButtonTitle)
        XCTAssertTrue(
            connectContactsScreen.continueButton.exists,
            "The user is not on the 'Connect Contacts' screen or the button doesn't exist."
        )
    }
    
    func test09AllowAccessToContacts() {
        connectContactsScreen.allowAccessToContacts()
        handleSystemAlert(title: Alert.connectContacts.title, buttonToTap: Alert.connectContacts.acceptButtonTitle)
        XCTAssertTrue(
            shareToInstagramScreen.skipButton.exists,
            "The user is not on the 'Invite Contats' screen or the button doesn't exist."
        )
    }
    
    func test10SkipSharingToInstagram() {
        shareToInstagramScreen.skipSharing()
        waitForElementToAppear(element: newConversationsScreen.newConversationsScreenTitle, time: 10)
    }
    
    // MARK: - Messages tab
    
    func test11OpenAppAsAuthorizedUser() {
        waitForElementToAppear(element: newConversationsScreen.newConversationsScreenTitle, time: 5)
    }
    
    func test12GoToAccountTab() {
        switchToTab( .accountTab)
        XCTAssertTrue(
            accountScreen.friendsLabel.exists,
            "The user is not on the 'Account' screen or the label doesn't exist."
        )
    }
    
    func test13SignOut() {
        switchToTab( .accountTab)
        accountScreen.signOut()
        handleAlert(title: Alert.signOut.title, buttonToTap: Alert.signOut.acceptButtonTitle)
        waitForElementToAppear(element: welcomeScreen.getStartedButton, time: 3)
    }
    
    // MARK: - Onboarding. Invite flow
    
    func test14DeleteApp() {
        deleteApp()
    }
    
    func test15InviteFlowVerification() {
        welcomeScreen.goToAuthorisationScreen()
        authorisationScreen.selectCountry(credentials.countryCode)
        authorisationScreen.typePhoneNumberAndProceed(phoneNumber: credentials.secondUserPhoneNumber)
        waitForElementToAppear(element: codeVerificationScreen.codeField, time: 10)
        codeVerificationScreen.typeVerificationCodeAndProceed(code: credentials.verificationCode)
        waitForElementToAppear(element: communityPrinciplesScreen.agreeButton, time: 5)
        communityPrinciplesScreen.agreeWithRulesAndProceed()
        notificationsScreen.allowNotificationsInviteFlow()
        handleSystemAlert(title: Alert.allowNotifications.title, buttonToTap: Alert.allowNotifications.acceptButtonTitle)
        connectContactsScreen.allowAccessToContactsInviteFlow()
        handleSystemAlert(title: Alert.connectContacts.title, buttonToTap: Alert.connectContacts.acceptButtonTitle)
        onboardingInviteContactsScreen.inviteContacts()
        shareToInstagramScreen.skipSharing()
        waitForElementToAppear(element: newConversationsScreen.newConversationsScreenTitle, time: 7)
    }
    
    // MARK: - Onboarding. Basic flow
    
    func test16ContactUs() {
        switchToTab( .accountTab)
        accountScreen.signOut()
        handleAlert(title: Alert.signOut.title, buttonToTap: Alert.signOut.acceptButtonTitle)
        waitForElementToAppear(element: welcomeScreen.getStartedButton, time: 3)
        welcomeScreen.goToAuthorisationScreen()
        waitForElementToAppear(element: authorisationScreen.countrySelectionField, time: 2)
        authorisationScreen.selectCountry(credentials.countryCode)
        authorisationScreen.typePhoneNumberAndProceed(phoneNumber: credentials.userUnderTestPhoneNumber)
        waitForElementToAppear(element: codeVerificationScreen.codeField, time: 5)
        codeVerificationScreen.typeVerificationCodeAndProceed(code: credentials.verificationCode)
        waitForElementToAppear(element: communityPrinciplesScreen.agreeButton, time: 5)
        communityPrinciplesScreen.agreeWithRulesAndProceed()
        notificationsScreen.allowNotifications()
        connectContactsScreen.contactUs()
        waitForElementToAppear(element: mailComposerScreen.mailSendButton, time: 3)
    }
    
    func test17DontInviteAllContactsAndGoToNewConverationsScreen(){
        connectContactsScreen.allowAccessToContacts()
        shareToInstagramScreen.skipSharing()
        waitForElementToAppear(element: newConversationsScreen.newConversationsScreenTitle, time: 10)
    }
    
    // MARK: - Messages tab

    func test18AbilityToChangeNicknameWhenCreatingNewChat() {
        goToNewGroupConversationScreen()
        let oldUserNickname = chatsHelper.getUserNickname()
        newGroupConversationScreen.generateNewNickname()
        let newUserNickname = chatsHelper.getUserNickname()
        XCTAssertTrue(
            oldUserNickname != newUserNickname,
            "The repeat button wasn't tapped."
        )
    }
    
    func test19StartConversation() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let chatTitle = Utils.generateNewChatComment()
        chatsHelper.sendMessage(chatTitle)
        newGroupConversationScreen.closeScreenAfterCreatingConversation()
        let titleExists = chatsHelper.checkIfGroupChatTitleExists(chatTitle)
        XCTAssertTrue(
            titleExists,
            "Chat wasn't created."
        )
    }
    
    // MARK: - Group chat screen
    
    func test20SubmitOver300Characters() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let messageText = String(repeating: "Test", count: 80)
        chatsHelper.sendMessage(messageText)
        let comment = chatsHelper.findComment(messageText)
        XCTAssertEqual(
            comment,
            messageText,
            "The comment is not on the screen."
        )
    }
    
    func test21SubmitEmoji() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let emoji = "🧪"
        chatsHelper.sendMessage(emoji)
        let comment = chatsHelper.findComment(emoji)
        XCTAssertEqual(
            comment,
            emoji,
            "The comment is not on the screen."
        )
    }
    
    func test22SubmitDigits() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let digits = "1321"
        chatsHelper.sendMessage(digits)
        let comment = chatsHelper.findComment(digits)
        XCTAssertEqual(
            comment,
            digits,
            "The comment is not on the screen."
        )
    }
    
    func test23SubmitSpecialCharacters() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let characters = "=)"
        chatsHelper.sendMessage(characters)
        let comment = chatsHelper.findComment(characters)
        XCTAssertEqual(
            comment,
            characters,
            "The comment is not on the screen."
        )
    }
    
    func test24SubmitMessageWithoutInternetAlertVerificaion() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let chatTitle = Utils.generateNewChatComment()
        chatsHelper.sendMessage(chatTitle)
        newGroupConversationScreen.closeScreenAfterCreatingConversation()
        chatsHelper.findAndOpenChatOnMessagesFeed(chatTitle)
        turnWifiOff()
        let message = Utils.generateComment()
        chatsHelper.sendMessage(message)
        handleAlert(title: Alert.noInternetConnection.title, buttonToTap: Alert.noInternetConnection.acceptButtonTitle)
        turnWifiOn()
    }
    
    func test25SubmitMessageWithoutInternetErrorTextVerification() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let chatTitle = Utils.generateNewChatComment()
        chatsHelper.sendMessage(chatTitle)
        newGroupConversationScreen.closeScreenAfterCreatingConversation()
        chatsHelper.findAndOpenChatOnMessagesFeed(chatTitle)
        turnWifiOff()
        let message = Utils.generateComment()
        chatsHelper.sendMessage(message)
        handleAlert(title: Alert.noInternetConnection.title, buttonToTap: Alert.noInternetConnection.acceptButtonTitle)
        XCTAssertTrue(
            groupChatScreen.messageNotSentErrorText.exists,
            "The error is not on the screen or the message was sent successfully."
        )
        turnWifiOn()
    }
    
    func test26ResendFailedMessage() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        turnWifiOff()
        let message = Utils.generateComment()
        chatsHelper.sendMessage(message)
        turnWifiOn()
        chatsHelper.longTap(over: groupChatScreen.messageNotSentErrorText)
        groupChatScreen.resendFailedMessage()
        XCTAssertFalse(
            groupChatScreen.messageNotSentErrorText.waitForExistence(timeout: 1.5),
            "The message was not resend. Check the internet connection or verify there is still 'messageNotSentErrorText'."
        )
    }
    
    func test27PullDownMenuVerification() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let chatTitle = Utils.generateNewChatComment()
        chatsHelper.sendMessage(chatTitle)
        newGroupConversationScreen.closeScreenAfterCreatingConversation()
        chatsHelper.findAndOpenChatOnMessagesFeed(chatTitle)
        groupChatScreen.openMoreOptions()
        XCTAssertTrue(
            groupChatScreen.viewDetailsButton.exists,
            "The 'View Details' button doesn't not exist or the 'more' button wasn't tapped."
        )
    }
    
    func test28MuteGroupConversation() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let chatTitle = Utils.generateNewChatComment()
        chatsHelper.sendMessage(chatTitle)
        newGroupConversationScreen.closeScreenAfterCreatingConversation()
        chatsHelper.findAndOpenChatOnMessagesFeed(chatTitle)
        groupChatScreen.muteConversation()
        waitForElementToAppear(element: groupChatScreen.conversationMutedSnackbar, time: 4)
    }
    
    func test29UnmuteGroupConversation() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let chatTitle = Utils.generateNewChatComment()
        chatsHelper.sendMessage(chatTitle)
        newGroupConversationScreen.closeScreenAfterCreatingConversation()
        chatsHelper.findAndOpenChatOnMessagesFeed(chatTitle)
        groupChatScreen.muteConversation()
        chatsHelper.dismissSnackBar(groupChatScreen.conversationMutedSnackbar)
        groupChatScreen.unmuteConversation()
        waitForElementToAppear(element: groupChatScreen.conversationUnmutedSnackbar, time: 4)
    }
    
    func test30GoToFriendsScreen() {
        switchToTab( .accountTab)
        accountScreen.goToFriendsScreen()
        XCTAssertTrue(
            friendsScreen.sendInvites.exists,
            "The label does not exist or user is not on the Friends screen."
        )
    }
    
    func test31GoToInviteContactsScreen() {
        switchToTab( .accountTab)
        accountScreen.goToFriendsScreen()
        friendsScreen.goToInviteContactsScreen()
        XCTAssertTrue(
            inviteContactsScreen.inviteContactsHeader.exists,
            "The user is not on the screen or the header does not exist."
        )
    }
    
    func test32DismissExplanationBannerOnSuggestedFeed() {
        newConversationsScreen.dismissBanner()
    }
    
    @MainActor
    func test32FollowedChatOnMessageTabVerification() async {
        let chatTitleToFollow = Utils.generateNewChatComment()
        let expectation = expectation(description: "Wating for new conversation")
        
        do {
            _ = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 40)
            newConversationsScreen.pullToRefresh()
            chatsHelper.followSuggestedChatFromSuggestedFeed(chatTitleToFollow)
            switchToTab( .messagesTab)
            try await Task.sleep(seconds: 1)
            let titleExist = chatsHelper.checkIfGroupChatTitleExists(chatTitleToFollow)
            XCTAssertTrue(
                titleExist,
                "Chat doesn't exist."
            )
        } catch {
            print(error)
        }
    }

    func test33ShuffleNamesInSomeoneGroupChat() {
        chatsHelper.openFirstChat()
        let oldUserNickname = chatsHelper.getUserNickname()
        newGroupConversationScreen.generateNewNickname()
        let newUserNickname = chatsHelper.getUserNickname()
        XCTAssertTrue(
            oldUserNickname != newUserNickname,
            "The repeat button wasn't tapped."
        )
    }

    @MainActor
    func test34UnmuteGroupChatBySendingMessage() async {
        let chatTitleToFollow = Utils.generateNewChatComment()
        let expectation = expectation(description: "Wating for new conversation")

        do {
            _ = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 40)
            newConversationsScreen.pullToRefresh()
            chatsHelper.followSuggestedChatFromSuggestedFeed(chatTitleToFollow)
            switchToTab( .messagesTab)
            chatsHelper.findAndOpenChatOnMessagesFeed(chatTitleToFollow)
            chatsHelper.sendMessage(Utils.generateComment())
            waitForElementToAppear(element: groupChatScreen.muteButton, time: 2)
        } catch {
            print(error)
        }
    }

    func test35AbilityToDeleteYourOwnMessage() {
        chatsHelper.openFirstChat()
        let myMessage = Utils.generateComment()
        chatsHelper.sendMessage(myMessage)
        let comment = chatsHelper.findCommentAsXcuiElement(myMessage)
        Thread.sleep(forTimeInterval: 0.5)
        chatsHelper.longTap(over: comment)
        chatsHelper.deleteComment()
        XCTAssertFalse(
            comment.exists,
            "The comment hasn't been deleted"
        )
    }

    @MainActor
    func test36AbilityToUnmuteSomeonesChat() async {
        let chatTitleToFollow = Utils.generateNewChatComment()
        let expectation = expectation(description: "Wating for new conversation")

        do {
            _ = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            newConversationsScreen.pullToRefresh()
            chatsHelper.followSuggestedChatFromSuggestedFeed(chatTitleToFollow)
            switchToTab( .messagesTab)
            chatsHelper.findAndOpenChatOnMessagesFeed(chatTitleToFollow)
            groupChatScreen.unmuteConversation()
            expectation.fulfill()
            waitForExpectations(timeout: 40)
            waitForElementToAppear(element: groupChatScreen.conversationUnmutedSnackbar, time: 5)
        } catch {
            print(error)
        }
    }

    @MainActor
    func test37AbilityToMuteSomeoneChat() async {
        let chatTitleToFollow = Utils.generateNewChatComment()
        let expectation = expectation(description: "Wating for new conversation")

        do {
            _ = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            newConversationsScreen.pullToRefresh()
            chatsHelper.followSuggestedChatFromSuggestedFeed(chatTitleToFollow)
            switchToTab( .messagesTab)
            chatsHelper.openFirstChat()
            groupChatScreen.unmuteConversation()
            expectation.fulfill()
            waitForExpectations(timeout: 40)
            chatsHelper.dismissSnackBar(groupChatScreen.conversationUnmutedSnackbar)
            groupChatScreen.muteConversation()
            waitForElementToAppear(element: groupChatScreen.conversationMutedSnackbar, time: 3)
        } catch {
            print(error)
        }
    }

    @MainActor
    func test38AbilityToReceiveOtherUserMessage() async {
        let chatTitleToFollow = Utils.generateNewChatComment()

        let expectation = expectation(description: "Wait")
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            newConversationsScreen.pullToRefresh()
            chatsHelper.findAndOpenChatOnSuggestedFeed(chatTitleToFollow)
            groupChatScreen.followChat()
            let commentFromSecondUser = Utils.generateComment()
            _ = try await apiSupportService.perform(
                action: .createComment,
                objectName: commentFromSecondUser,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            let foundComment = chatsHelper.findComment(commentFromSecondUser)
            XCTAssertEqual(
                commentFromSecondUser,
                foundComment,
                "There is no comment from second user."
            )
        } catch {
            print(error)
        }
    }

    @MainActor
    func test39AbilityToReportUserMessage() async {
        let expectation = expectation(description: "Wait for new conversation")
        let chatTitleToFollow = Utils.generateNewChatComment()

        do {
            _ = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 40)
            newConversationsScreen.pullToRefresh()
            chatsHelper.findAndOpenChatOnSuggestedFeed(chatTitleToFollow)
            groupChatScreen.followChat()
            try await Task.sleep(seconds: 0.2)
            chatsHelper.dismissSnackBar(groupChatScreen.followedSnackBar)
            let secondUserComment = chatsHelper.findCommentAsXcuiElement(chatTitleToFollow)
            chatsHelper.longTap(over: secondUserComment)
            groupChatScreen.reportMessage()
            reportMessageScreen.report(for: ReportMessageScreen.ReportMessageReasons.other)
            otherReasonReportScreen.submitReport()
            waitForElementToAppear(element: reportMessageSuccessScreen.thankYouStaticText, time: 2)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test40AbilityToBlockAndUnblockUser() async {
        let expectation = expectation(description: "Wait for new conversation")
        let chatTitleToFollow = Utils.generateNewChatComment()

        do {
            _ = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 40)
            newConversationsScreen.pullToRefresh()
            chatsHelper.followSuggestedChatFromSuggestedFeed(chatTitleToFollow)
            chatsHelper.openFirstChat()
            waitForElementToAppear(element: groupChatScreen.userNickname, time: 5)
            groupChatScreen.openUserMiniProfile()
            groupChatScreen.selectBlockUserOption()
            groupChatScreen.blockUser()
            waitForElementToAppear(element: groupChatScreen.userNickname, time: 5)
            groupChatScreen.openUserMiniProfile()
            groupChatScreen.unblockUser()
            groupChatScreen.openUserMiniProfile()
            waitForElementToAppear(element: groupChatScreen.blockUserOption, time: 3)
        } catch {
            print(error)
        }
    }

    @MainActor
    func test41AbilityToCreateDirectMessage() async {
        let expectation = expectation(description: "Wait for new conversation")
        let chatTitleToFollow = Utils.generateNewChatComment()

        do {
            _ = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 50)
            newConversationsScreen.pullToRefresh()
            chatsHelper.followSuggestedChatFromSuggestedFeed(chatTitleToFollow)
            switchToTab( .messagesTab)
            chatsHelper.findAndOpenChatOnMessagesFeed(chatTitleToFollow)
            waitForElementToAppear(element: groupChatScreen.userNickname, time: 5)
            groupChatScreen.openUserMiniProfile()
            groupChatScreen.directMessage()
            let dmCommentText = Utils.generateDmComment()
            chatsHelper.sendMessage(dmCommentText)
            chatsHelper.goBackFromChatScreen()
            chatsHelper.goBackFromChatScreen()
            XCTAssertTrue(
                chatsHelper.checkIfLastDmMessageExists(dmCommentText),
                "DM chat wasn't created."
            )
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test42RejectedMessageVerification() async {
        let expectation = expectation(description: "Wait")
        let chatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let commentId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            chatsHelper.findAndOpenChatOnMessagesFeed(chatTitle)
            _ = try await apiSupportService.perform(
                action: .rejectComment,
                objectName: "",
                objectId: commentId,
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 40)
            let rejectedLabelExists = chatsHelper.commentRejectionLabelExists(chatTitle)
            XCTAssertTrue(
                rejectedLabelExists,
                "Comment wasn't rejected."
            )
        } catch {
            print(error)
        }
    }
    
    func test43AbilityToArchiveUnarchiveGroupChat() {
        switchToTab( .messagesTab)
        goToNewGroupConversationScreen()
        let newChatText = Utils.generateNewChatComment()
        chatsHelper.sendMessage(newChatText)
        groupChatScreen.openMoreOptions()
        groupChatScreen.archiveConversation()
        newGroupConversationScreen.closeScreenAfterCreatingConversation()
        switchToTab( .accountTab)
        accountScreen.goToArchivedConversationsScreen()
        chatsHelper.findAndOpenChatOnMessagesFeed(newChatText)
        groupChatScreen.openMoreOptions()
        groupChatScreen.unarchiveConversation()
        waitForElementToAppear(element: groupChatScreen.conversationUnarchivedSnackbar, time: 2)
        chatsHelper.dismissSnackBar(groupChatScreen.conversationUnarchivedSnackbar)
        chatsHelper.goBackFromArchivedChat()
        switchToTab( .messagesTab)
        let unarchivedChat = chatsHelper.checkIfGroupChatTitleExists(newChatText)
        XCTAssertTrue(
            unarchivedChat,
            "The chat wasn't unarchived."
        )
    }

    // MARK: - Messages tab

    @MainActor
    func test44BadgeAppearanceDisappearanceOnGroupChat() async {
        let expectation = expectation(description: "Wait")
        let chatTitleToFollow = Utils.generateNewChatComment()

        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitleToFollow,
                objectId: "null",
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            newConversationsScreen.pullToRefresh()
            chatsHelper.followSuggestedChatFromSuggestedFeed(chatTitleToFollow)
            switchToTab( .messagesTab)
            chatsHelper.openFirstChat()
            groupChatScreen.unmuteConversation()
            try await Task.sleep(seconds: 0.2)
            chatsHelper.dismissSnackBar(groupChatScreen.conversationUnmutedSnackbar)
            chatsHelper.goBackFromChatScreen()
            _ = try await apiSupportService.perform(
                action: .createComment,
                objectName: Utils.generateComment(),
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            waitForElementToAppear(element: messagesScreen.badge, time: 10)
            XCTAssertTrue(
                chatsHelper.checkIfBadgeExists(chatTitleToFollow),
                "The badge didn't appear."
            )
            chatsHelper.findAndOpenChatOnMessagesFeed(chatTitleToFollow)
            waitForElementToAppear(element: groupChatScreen.backButton, time: 10)
            chatsHelper.goBackFromChatScreen()
            XCTAssertFalse(
                chatsHelper.checkIfBadgeExists(chatTitleToFollow),
                "The badge didn't disappear."
            )
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test45AbilityToReceiveNewDmChat() async {
        let expectation = expectation(description: "Wait")
        let chatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            let dmComment = Utils.generateDmComment()
            try await Task.sleep(seconds: 2)
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: dmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            try await Task.sleep(seconds: 2)
            let isDmExists = chatsHelper.checkIfLastDmMessageExists(dmComment)
            XCTAssertTrue(
                isDmExists,
                "User didn't receive DM."
            )
        } catch {
            print(error)
        }
    }
    
    // MARK: - Direct Message screen
    
    @MainActor
    func test46abilityToUnmuteAndMuteDmChat() async {
        let expectation = expectation(description: "Wait")
        let chatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            let dmComment = Utils.generateDmComment()
            try await Task.sleep(seconds: 2)
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: dmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            chatsHelper.findAndOpenChatOnMessagesFeed(dmComment)
            groupChatScreen.unmuteConversation()
            waitForElementToAppear(element: groupChatScreen.conversationUnmutedSnackbar, time: 2)
            chatsHelper.dismissSnackBar(groupChatScreen.conversationUnmutedSnackbar)
            groupChatScreen.muteConversation()
            waitForElementToAppear(element: groupChatScreen.conversationMutedSnackbar, time: 2)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test47AbilityToUnmuteDmByReplying() async {
        let expectation = expectation(description: "Wait")
        let chatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            let dmComment = Utils.generateDmComment()
            try await Task.sleep(seconds: 2)
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: dmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            chatsHelper.findAndOpenChatOnMessagesFeed(dmComment)
            chatsHelper.sendMessage(Utils.generateDmComment())
            waitForElementToAppear(element: groupChatScreen.muteButton, time: 3)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test48AbilityToArchiveAndUnarchiveDmChat() async {
        let expectation = expectation(description: "Wait")
        let chatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            let dmComment = Utils.generateDmComment()
            try await Task.sleep(seconds: 2)
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: dmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            chatsHelper.findAndOpenChatOnMessagesFeed(dmComment)
            groupChatScreen.openMoreOptions()
            dmChatScreen.archiveConversation()
            waitForElementToAppear(element: groupChatScreen.moreButton, time: 3)
            groupChatScreen.openMoreOptions()
            dmChatScreen.unarchiveConversation()
            waitForElementToAppear(element: groupChatScreen.moreButton, time: 3)
            groupChatScreen.openMoreOptions()
            waitForElementToAppear(element: dmChatScreen.archiveButton, time: 3)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test49AbilityToReceiveMessageInExistingDm() async {
        let expectation = expectation(description: "Wait")
        let chatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            let dmComment = Utils.generateDmComment()
            try await Task.sleep(seconds: 2)
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: dmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            chatsHelper.findAndOpenChatOnMessagesFeed(dmComment)
            let secondDmComment = Utils.generateDmComment()
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: secondDmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            let foundComment = chatsHelper.findComment(secondDmComment)
            XCTAssertEqual(
                foundComment,
                secondDmComment,
                "The comment wasn't found or created."
            )
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test50NavigateFromDmToParentChatAndBackToMessagesTab() async {
        let expectation = expectation(description: "Wait")
        let parentChatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: parentChatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            try await Task.sleep(seconds: 2)
            let dmComment = Utils.generateDmComment()
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: dmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            chatsHelper.findAndOpenChatOnMessagesFeed(dmComment)
            dmChatScreen.goToParentChat(parentChatTitle)
            let foundCommentInGroupChat = chatsHelper.findComment(parentChatTitle)
            XCTAssertEqual(
                foundCommentInGroupChat,
                parentChatTitle,
                "User didn't come to the parent group chat."
            )
            chatsHelper.goBackFromChatScreen()
            chatsHelper.goBackFromChatScreen()
            let isDmChatOnMessageTab = chatsHelper.checkIfLastDmMessageExists(dmComment)
            XCTAssertTrue(
                isDmChatOnMessageTab,
                "User is not on the Messages tab."
            )
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func test51BadgeAppearanceDisappearanceOnDmChatVerification() async {
        let expectation = expectation(description: "Wait")
        let chatTitle = Utils.generateNewChatComment()
        switchToTab( .messagesTab)
        
        do {
            let chatId = try await apiSupportService.perform(
                action: .createPost,
                objectName: chatTitle,
                objectId: "null",
                userId: credentials.userUnderTestId,
                userNickname: credentials.userUnderTestNickname
            )
            let dmComment = Utils.generateDmComment()
            try await Task.sleep(seconds: 2)
            _ = try await apiSupportService.perform(
                action: .createDM,
                objectName: dmComment,
                objectId: chatId,
                userId: credentials.secondUserId,
                userNickname: credentials.secondUserNickname
            )
            expectation.fulfill()
            waitForExpectations(timeout: 60)
            waitForElementToAppear(element: messagesScreen.badge, time: 10)
            XCTAssertTrue(
                chatsHelper.checkIfBadgeExists(dmComment),
                "There is no badge or the message wasn't sent."
            )
            chatsHelper.findAndOpenChatOnMessagesFeed(dmComment)
            chatsHelper.goBackFromChatScreen()
            XCTAssertFalse(
                chatsHelper.checkIfBadgeExists(dmComment),
                "The badge didn't disappear."
            )
        } catch {
            print(error)
        }
    }
}
