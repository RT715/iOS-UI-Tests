<p align="center">
      <img src="https://i.ibb.co/bRhNT9w/Open-icon.jpg" width="426">
</p>

## About

An automated tests for iOS messaging application where 2 users communicate with each other in group or DM chats. The tests are veifying features like: Authentication, Onboarding passing, Creating new group and DM chats, Verification of receiving new group and DM chats from other users, Verification of receiving new messages from other users, Following/unfollowing, muting/unmuting, archiving/unarchiving group chats.

## Execution details

The tests are kind of tricky. E.G. To verify that 1 user received a message from other user, the message itself needs to be moderated and after moderation approval it will appear in a particular chat. To approve a message there should be performed a couple of actions by triggering http handlers. And to avoid sending a lot of requests from the tests, there was a server has been written by my colleague where all neccesary handlers were stored in one place to perform a particular actions from user's side.

The service link: https://github.com/haenar/MobileAutotestPreconditions

I was performing an HTTPS async requests from my tests to that server using urlsession library, the magic were happening on the server side, and I parsed the response to get the data for further tests execution. I used a self-signed certificate that was generated on the server side to be able to send an HTTPS requests to not trusted source according to Swift restrictions.

The tests are written using Page Object Model pattern.
