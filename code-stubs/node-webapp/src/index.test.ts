import express from 'express'

describe('App', () => {
  test('should be the same port to config', async () => {
    const app = express()
    app.set('port', 3000)
    expect(app.get('port')).toBe(3000)
  })
})
