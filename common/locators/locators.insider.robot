*** Settings ***
Resource    ../variables.robot
*** Variables ***
${title.text}      1 Leader in Individualized, Cross-Channel CX — Insider
${title.locator}      xpath=//meta[@property='og:title']
${menu.company}     xpath=//a[contains(text(),'Company')]
${menu.company.careers}     xpath=//a[contains(text(),'Careers')]
${menu.company.careers.url}     https://useinsider.com/careers/
${careers.lifeatinsider.block}      xpath=//h2[contains(text(),'Life at Insider')]
${careers.qa.seealljobs}    xpath=//a[contains(text(),'See all QA jobs')]
${careers.qa.location.filter.istanbul.selected}    xpath=//span[@class='select2-selection__rendered' and contains(text(), 'Istanbul, Turkey')]
${careers.qa.filterbylocationdropwown}    xpath=//span[@id='select2-filter-by-location-container']
${careers.qa.filterbylocationresults}    xpath=//ul[@id='select2-filter-by-location-results']
${careers.qa.filterbydepartmentdropwown}    xpath=//span[@id='select2-filter-by-department-container']
${careers.qa.filterbylocationIstambul}      xpath=//li[@class='select2-results__option' and contains(text(), 'Istanbul, Turkey')]
${careers.qa.filterbydepartmentqa}      xpath=//span[@id='select2-filter-by-department-container' and contains(text(), 'Quality Assurance')]
${careers.qa.numberofjobs}    xpath=//span[@id='deneme']
${careers.qa.viewrolebutton}   xpath=//a[contains(text(),'View Role')]
${careers.qa.joblist}      xpath=//div[@id='jobs-list']
${company.careers.url}      https://useinsider.com/careers/
${company.careers.qa.url}      https://useinsider.com/careers/quality-assurance/
${company.careers.qa.open.positions.url}      https://useinsider.com/careers/open-positions/?department=qualityassurance
${role.description.page.header}    //h2[contains(text(),'Quality Assurance')]




