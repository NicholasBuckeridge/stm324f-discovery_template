/**
  ******************************************************************************
  * @file    main.c 
  * @author  MCD Application Team
  * @version V1.0.0
  * @date    18-April-2011
  * @brief   Main program body
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************  
  */ 

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx.h"
#include "stm32f4xx_rcc.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_tim.h"
#include "stm32f4xx_syscfg.h"
#include "stm32f4xx_exti.h"
#include "stm32f4xx_dma.h"
#include "misc.h"
#include "stm32f4_discovery.h"
#include "stm32f4xx_usart.h"
#include <stdio.h>
//#include "usart.h" this file and it's source file are intergrated into this code file






#define	USART2_OPEN
//#define	USART3_OPEN

/**
 * @brief Definition for COM port1, connected to USART3
 */  
#ifdef	USART2_OPEN
	#define Open_USART                        USART2
	#define Open_USART_CLK                    RCC_APB1Periph_USART2
	
	#define Open_USART_TX_PIN                 GPIO_Pin_2
	#define Open_USART_TX_GPIO_PORT           GPIOA
	#define Open_USART_TX_GPIO_CLK            RCC_AHB1Periph_GPIOA
	#define Open_USART_TX_SOURCE              GPIO_PinSource2
	#define Open_USART_TX_AF                  GPIO_AF_USART2
	
	
	#define Open_USART_RX_PIN                 GPIO_Pin_3
	#define Open_USART_RX_GPIO_PORT           GPIOA
	#define Open_USART_RX_GPIO_CLK            RCC_AHB1Periph_GPIOA
	#define Open_USART_RX_SOURCE              GPIO_PinSource3
	#define Open_USART_RX_AF                  GPIO_AF_USART2
	
	#define Open_USART_IRQn                   USART2_IRQn
	#define USARTx_IRQHANDLER  				  USART2_IRQHandler

#elif	defined	USART3_OPEN
	#define Open_USART                        USART3
	#define Open_USART_CLK                    RCC_APB1Periph_USART3
	
	#define Open_USART_TX_PIN                 GPIO_Pin_10
	#define Open_USART_TX_GPIO_PORT           GPIOC
	#define Open_USART_TX_GPIO_CLK            RCC_AHB1Periph_GPIOC
	#define Open_USART_TX_SOURCE              GPIO_PinSource10
	#define Open_USART_TX_AF                  GPIO_AF_USART3
	
	
	#define Open_USART_RX_PIN                 GPIO_Pin_11
	#define Open_USART_RX_GPIO_PORT           GPIOC
	#define Open_USART_RX_GPIO_CLK            RCC_AHB1Periph_GPIOC
	#define Open_USART_RX_SOURCE              GPIO_PinSource11
	#define Open_USART_RX_AF                  GPIO_AF_USART3
	
	#define Open_USART_IRQn                   USART3_IRQn
	#define USARTx_IRQHANDLER  				  USART3_IRQHandler
#else
	#error "Please select The COM to be used (in usart.h)"
#endif 		 

void USART_Configuration(void);
void USART_NVIC_Config(void);



class sys
{
public:
	sys()
	{
		USART_Configuration();
		USART_NVIC_Config();
	}
	~sys(){}
private:
	void USART_Configuration(void);
	void USART_NVIC_Config(void);
};





int main(void)
{
	//uint32_t i;
	//USART_Configuration();
	//USART_NVIC_Config();
	//i=0x1ffffff;
	while (1)
	{
		printf("\r\nWelcome to WaveShare STM32F4 series MCU Board Open407Z\r\n");
		//USART_SendData(Open_USART, (uint8_t) 'N');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		//USART_SendData(Open_USART, (uint8_t) 'i');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		//USART_SendData(Open_USART, (uint8_t) 'c');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		//USART_SendData(Open_USART, (uint8_t) '\n');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		for(uint32_t ii = 0; ii<0xFFFFFFF; ii++){
		for(uint32_t iii = 0; iii<0x1; iii++){
		}
		}
	}
}

/**
  * @}
  */ 

/**
  * @}
  */ 




//----------------------------------------------------------------------------------------------------------------------------------------




void USARTx_IRQHANDLER(void)
{
  if(USART_GetITStatus(Open_USART, USART_IT_RXNE) != RESET)
  { 
  		//USART_ClearITPendingBit(USART2,USART_IT_RXNE);
		//printf("\n\rUSART Hyperterminal Interrupts Receive a word: %c\n\r",USART_ReceiveData(Open_USART));
		USART_SendData(Open_USART, (uint8_t) 'D');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		USART_SendData(Open_USART, (uint8_t) 'a');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		USART_SendData(Open_USART, (uint8_t) 't');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		USART_SendData(Open_USART, (uint8_t) 'a');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		USART_SendData(Open_USART, (uint8_t) ':');while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
		USART_SendData(Open_USART, (uint8_t) USART_ReceiveData(Open_USART));while (USART_GetFlagStatus(Open_USART, USART_FLAG_TC) == RESET){}
  }
}



//----------------------------------------------------------------------------------------------------------------------------------------





/*******************************************************************************
* Function Name  : USART_Configuration
* Description    : Configure Open_USART 
* Input          : None
* Output         : None
* Return         : None
* Attention		 : None
*******************************************************************************/
void sys::USART_Configuration(void)
{ 												
  GPIO_InitTypeDef GPIO_InitStructure;
  USART_InitTypeDef USART_InitStructure; 

  RCC_AHB1PeriphClockCmd(Open_USART_TX_GPIO_CLK,ENABLE);
  RCC_AHB1PeriphClockCmd(Open_USART_RX_GPIO_CLK,ENABLE);

  #ifdef	USART1_OPEN
  	RCC_APB2PeriphClockCmd(Open_USART_CLK,ENABLE);
  #else
  	RCC_APB1PeriphClockCmd(Open_USART_CLK,ENABLE);
  #endif	


  GPIO_PinAFConfig(Open_USART_TX_GPIO_PORT, Open_USART_TX_SOURCE, Open_USART_TX_AF);
  GPIO_PinAFConfig(Open_USART_RX_GPIO_PORT, Open_USART_RX_SOURCE, Open_USART_RX_AF);

  /*
  *  Open_USART_TX -> PA9 , Open_USART_RX -PA10
  */
  GPIO_InitStructure.GPIO_Pin = Open_USART_TX_PIN;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;

  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
  GPIO_Init(Open_USART_TX_GPIO_PORT, &GPIO_InitStructure);

  GPIO_InitStructure.GPIO_Pin = Open_USART_RX_PIN;
  GPIO_InitStructure.GPIO_OType = GPIO_OType_OD;
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
  GPIO_Init(Open_USART_RX_GPIO_PORT, &GPIO_InitStructure);

/*
   		 USARTx configured as follow:
         - BaudRate = 115200 baud  
		 - Word Length = 8 Bits
         - One Stop Bit
         - No parity
         - Hardware flow control disabled (RTS and CTS signals)
         - Receive and transmit    
 */

  USART_InitStructure.USART_BaudRate = 9600;
  USART_InitStructure.USART_WordLength = USART_WordLength_8b;
  USART_InitStructure.USART_StopBits = USART_StopBits_1;
  USART_InitStructure.USART_Parity = USART_Parity_No;
  USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
  USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
  USART_Init(Open_USART, &USART_InitStructure);
  /* Enable the Open_USART Transmit interrupt: this interrupt is generated when the 
     Open_USART transmit data register is empty */
  USART_ITConfig(Open_USART,USART_IT_RXNE,ENABLE);

  USART_Cmd(Open_USART, ENABLE);

}

void sys::USART_NVIC_Config(void)
{
  NVIC_InitTypeDef NVIC_InitStructure;

  /* Enable the USARTx Interrupt */
  NVIC_InitStructure.NVIC_IRQChannel = Open_USART_IRQn;
  NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
  NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  NVIC_Init(&NVIC_InitStructure);
}


