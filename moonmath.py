import asyncio
from pyppeteer import launch
import time

async def main():
    browser = await launch()
    page = await browser.newPage()
    await page.setViewport({'width': 1280, 'height': 1620})
    await page.goto('https://www.moonmath.win/')

    await page.evaluate('''
        () => {
            function getElementByXpath(path) {
                return document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
            }
            e = getElementByXpath('//*[@id="headingOne"]/h5/button')
            e.click()
            return { }
        }
    ''')
    time.sleep(0.5)

    await page.screenshot({'path': 'moonmath.png',
        'clip': {'x': 20, 'y':600, 'width': 1210, 'height': 790}})
    await browser.close()

def captureSS():
    asyncio.get_event_loop().run_until_complete(main())