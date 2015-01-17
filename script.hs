{-# LANGUAGE OverloadedStrings #-}
import Test.WebDriver
import Test.WebDriver.Common.Profile (Profile, ProfilePref(PrefString))
import Test.WebDriver.Firefox.Profile (Firefox, defaultProfile, profilePrefs)
import qualified Data.HashMap.Strict as HM

myConfig :: WDConfig
-- myConfig = defaultConfig
myConfig =
    let profile :: Profile Firefox
        profile = defaultProfile {profilePrefs = HM.insert "general.useragent.override" (PrefString "Mozilla/5.0 (compatible, MSIE 11, Windows NT 6.3; Trident/7.0;  rv:11.0) like Gecko") (profilePrefs defaultProfile)} in
    defaultConfig {wdCapabilities =
                       (wdCapabilities defaultConfig) {browser =
                                                           (browser $ wdCapabilities defaultConfig) {ffProfile = Just profile}}}
 
main :: IO ()
main = runSession myConfig $ do
         openPage "https://secure-session.com/login.asp"
-- -A "Mozilla/5.0 (compatible, MSIE 11, Windows NT 6.3; Trident/7.0;  rv:11.0) like Gecko"
-- -d  'Username=thompsonmartinez&Password=fineart&x=10&y=10&Remember=Yes&CommunityID=1'
         searchInput <- findElem (ByCSS "input[type='text']")
         sendKeys "Hello, World!" searchInput
