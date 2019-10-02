{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_countdown (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/peter/haskell/countdown/.cabal-sandbox/bin"
libdir     = "/home/peter/haskell/countdown/.cabal-sandbox/lib/x86_64-linux-ghc-8.6.4/countdown-0.1.0.0-2AkkAek86fHCtxV49aO0ud-countdown"
dynlibdir  = "/home/peter/haskell/countdown/.cabal-sandbox/lib/x86_64-linux-ghc-8.6.4"
datadir    = "/home/peter/haskell/countdown/.cabal-sandbox/share/x86_64-linux-ghc-8.6.4/countdown-0.1.0.0"
libexecdir = "/home/peter/haskell/countdown/.cabal-sandbox/libexec/x86_64-linux-ghc-8.6.4/countdown-0.1.0.0"
sysconfdir = "/home/peter/haskell/countdown/.cabal-sandbox/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "countdown_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "countdown_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "countdown_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "countdown_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "countdown_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "countdown_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
