import express from 'express'

const start = async (): Promise<void> => {
  const app = express()

  app.listen(app.get('port'), () => {
    console.log(
      `⚡ App is running at :%d in %s mode`,
      app.get('port'),
      app.get('env')
    )
    console.log('  Press CTRL-C to stop' + '\n')
  })
}
start()
